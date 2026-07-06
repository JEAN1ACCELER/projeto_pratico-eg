import PDFDocument from "pdfkit";
import { prisma } from "../../infrastructure/prisma.js";

// Paleta institucional UFAM (verde)
const COR_PRIMARIA = "#00663C";
const COR_SECUNDARIA = "#00855B";
const COR_CINZA = "#555555";

/**
 * Gera um PDF completo de um único projeto, com:
 * cabeçalho, informações, resumo de progresso, tarefas (com entregas)
 * e reuniões realizadas.
 */
export async function gerarRelatorioProjeto(projetoId: string): Promise<Buffer> {
  const projeto = await prisma.projeto.findUnique({
    where: { id: projetoId },
    include: {
      orientador: { select: { nomeCompleto: true, emailInstitucional: true } },
      orientando: { select: { nomeCompleto: true, emailInstitucional: true } },
      tarefas: {
        orderBy: { createdAt: "asc" },
        include: { entrega: true },
      },
      reunioes: {
        orderBy: { dataHora: "desc" },
        include: { presencas: { include: { usuario: { select: { nomeCompleto: true } } } } },
      },
    },
  });

  if (!projeto) throw new Error("Projeto não encontrado");

  const totalTarefas = projeto.tarefas.length;
  const concluidas = projeto.tarefas.filter((t) => t.status === "CONCLUIDO").length;
  const emAndamento = projeto.tarefas.filter((t) => t.status === "EM_ANDAMENTO").length;
  const aFazer = projeto.tarefas.filter((t) => t.status === "A_FAZER").length;
  const progresso = totalTarefas > 0 ? Math.round((concluidas / totalTarefas) * 100) : 0;

  return new Promise((resolve, reject) => {
    const doc = new PDFDocument({ margin: 50 });
    const buffers: Buffer[] = [];
    doc.on("data", (buf: Buffer) => buffers.push(buf));
    doc.on("end", () => resolve(Buffer.concat(buffers)));
    doc.on("error", reject);

    // ===== Cabeçalho =====
    doc
      .fillColor(COR_PRIMARIA)
      .fontSize(22)
      .font("Helvetica-Bold")
      .text("E-Project", { align: "center" });
    doc
      .fillColor(COR_CINZA)
      .fontSize(11)
      .font("Helvetica")
      .text("Relatório de Projeto de Pesquisa e Extensão", { align: "center" });
    doc.fontSize(9).text("Universidade Federal do Amazonas — ICET", { align: "center" });

    // Linha separadora colorida
    doc.moveDown(0.4);
    let y = doc.y;
    doc.save().moveTo(50, y).lineTo(doc.page.width - 50, y).lineWidth(2).strokeColor(COR_PRIMARIA).restore();
    doc.moveDown(1);

    // ===== Título do projeto =====
    doc
      .fillColor("#000")
      .fontSize(16)
      .font("Helvetica-Bold")
      .text(projeto.titulo, { align: "center" });
    doc.moveDown(0.3);
    doc
      .fontSize(10)
      .font("Helvetica")
      .fillColor(COR_SECUNDARIA)
      .text(`${labelModalidade(projeto.modalidade)} • ${labelStatusProjeto(projeto.status)}`, { align: "center" });
    doc.fillColor("#000").moveDown(1);

    // ===== Informações do projeto =====
    secao(doc, "Informações Gerais");
    linhaInfo(doc, "Período", `${formatDate(projeto.dataInicio)} a ${formatDate(projeto.dataTermino)}`);
    linhaInfo(doc, "Orientador(a)", `${projeto.orientador.nomeCompleto} (${projeto.orientador.emailInstitucional})`);
    linhaInfo(doc, "Orientando(a)", `${projeto.orientando.nomeCompleto} (${projeto.orientando.emailInstitucional})`);
    if (projeto.resumo) {
      doc.moveDown(0.3).fontSize(10).font("Helvetica-Bold").fillColor("#000").text("Resumo:");
      doc.font("Helvetica").fillColor(COR_CINZA).text(projeto.resumo, { align: "justify" });
    }
    doc.moveDown(1);

    // ===== Progresso (barra visual) =====
    secao(doc, "Progresso");
    linhaInfo(doc, "Tarefas concluídas", `${concluidas} de ${totalTarefas}`);
    linhaInfo(doc, "Em andamento", `${emAndamento}`);
    linhaInfo(doc, "A fazer", `${aFazer}`);
    linhaInfo(doc, "Progresso geral", `${progresso}%`);

    // Barra de progresso
    doc.moveDown(0.4);
    const barraX = 50;
    const barraW = doc.page.width - 100;
    const barraY = doc.y;
    doc.save();
    doc.rect(barraX, barraY, barraW, 12).fillColor("#E0E0E0").fill();
    doc.rect(barraX, barraY, Math.max(barraW * (progresso / 100), 4), 12).fillColor(COR_PRIMARIA).fill();
    doc.restore();
    doc.fillColor("#000").moveDown(1.5);

    // ===== Tarefas =====
    secao(doc, `Tarefas (${totalTarefas})`);
    if (totalTarefas === 0) {
      doc.fontSize(10).font("Helvetica").fillColor(COR_CINZA).text("Nenhuma tarefa cadastrada.");
    } else {
      projeto.tarefas.forEach((t, i) => {
        const icone = t.status === "CONCLUIDO" ? "[✓]" : t.status === "EM_ANDAMENTO" ? "[~]" : "[ ]";
        doc
          .fontSize(11)
          .font("Helvetica-Bold")
          .fillColor("#000")
          .text(`${icone} ${i + 1}. ${t.titulo}`);
        doc
          .fontSize(9)
          .font("Helvetica")
          .fillColor(COR_CINZA)
          .text(`     Status: ${labelStatusTarefa(t.status)}${t.dataConclusao ? ` • Concluída em ${formatDate(t.dataConclusao)}` : ""}`);

        // Entrega associada
        if (t.entrega) {
          doc
            .fontSize(9)
            .fillColor(COR_SECUNDARIA)
            .text(
              `     Entrega: ${labelAvaliacao(t.entrega.statusAvaliacao)} • Enviada em ${formatDate(t.entrega.dataEnvio)}`,
            );
          if (t.entrega.feedbackOrientador) {
            doc.fillColor(COR_CINZA).text(`     Feedback: ${t.entrega.feedbackOrientador}`);
          }
        }
        doc.moveDown(0.3);
      });
    }
    doc.moveDown(1);

    // ===== Reuniões =====
    secao(doc, `Reuniões (${projeto.reunioes.length})`);
    if (projeto.reunioes.length === 0) {
      doc.fontSize(10).font("Helvetica").fillColor(COR_CINZA).text("Nenhuma reunião registrada.");
    } else {
      projeto.reunioes.forEach((r, i) => {
        doc
          .fontSize(11)
          .font("Helvetica-Bold")
          .fillColor("#000")
          .text(`${i + 1}. ${formatDateTime(r.dataHora)}${r.local ? ` — ${r.local}` : ""}`);
        if (r.resumo) {
          doc.fontSize(9).font("Helvetica").fillColor(COR_CINZA).text(`     Resumo: ${r.resumo}`);
        }
        if (r.presencas.length > 0) {
          doc
            .fontSize(9)
            .fillColor(COR_SECUNDARIA)
            .text(`     Presentes (${r.presencas.length}): ${r.presencas.map((p) => p.usuario.nomeCompleto).join(", ")}`);
        }
        doc.moveDown(0.3);
      });
    }

    // ===== Rodapé =====
    doc.moveDown(2);
    y = doc.y;
    doc.save().moveTo(50, y).lineTo(doc.page.width - 50, y).lineWidth(1).strokeColor(COR_PRIMARIA).restore();
    doc.moveDown(0.5);
    doc
      .fontSize(8)
      .fillColor(COR_CINZA)
      .font("Helvetica")
      .text(
        `Documento gerado automaticamente pelo E-Project em ${new Date().toLocaleString("pt-BR")}`,
        { align: "center" },
      );

    doc.end();
  });
}

/**
 * Gera um PDF consolidado com todos os projetos do usuário,
 * com sumário executivo e detalhamento por projeto.
 */
export async function gerarRelatorioGeral(usuarioId: string, papel: string): Promise<Buffer> {
  const where: any = {};
  if (papel === "PROFESSOR") where.orientadorId = usuarioId;
  else if (papel === "ALUNO") where.orientandoId = usuarioId;

  const projetos = await prisma.projeto.findMany({
    where,
    include: {
      orientador: { select: { nomeCompleto: true } },
      orientando: { select: { nomeCompleto: true } },
      tarefas: { select: { status: true } },
    },
    orderBy: { createdAt: "desc" },
  });

  const totalProjetos = projetos.length;
  const ativos = projetos.filter((p) => p.status === "EM_ANDAMENTO").length;
  const concluidos = projetos.filter((p) => p.status === "CONCLUIDO").length;
  const pendentes = projetos.filter((p) => p.status === "PENDENTE").length;
  const totalTarefas = projetos.reduce((s, p) => s + p.tarefas.length, 0);
  const tarefasConcluidas = projetos.reduce(
    (s, p) => s + p.tarefas.filter((t) => t.status === "CONCLUIDO").length,
    0,
  );

  return new Promise((resolve, reject) => {
    const doc = new PDFDocument({ margin: 50 });
    const buffers: Buffer[] = [];
    doc.on("data", (buf: Buffer) => buffers.push(buf));
    doc.on("end", () => resolve(Buffer.concat(buffers)));
    doc.on("error", reject);

    // ===== Capa =====
    doc.fillColor(COR_PRIMARIA).fontSize(26).font("Helvetica-Bold").text("E-Project", { align: "center" });
    doc
      .fillColor(COR_CINZA)
      .fontSize(12)
      .font("Helvetica")
      .text("Relatório Consolidado de Projetos", { align: "center" });
    doc.fontSize(9).text("Universidade Federal do Amazonas — ICET", { align: "center" });

    doc.moveDown(0.4);
    let y = doc.y;
    doc.save().moveTo(50, y).lineTo(doc.page.width - 50, y).lineWidth(2).strokeColor(COR_PRIMARIA).restore();
    doc.moveDown(1.5);

    // ===== Sumário executivo =====
    secao(doc, "Sumário Executivo");
    linhaInfo(doc, "Total de projetos", `${totalProjetos}`);
    linhaInfo(doc, "Projetos ativos", `${ativos}`);
    linhaInfo(doc, "Projetos concluídos", `${concluidos}`);
    linhaInfo(doc, "Projetos pendentes", `${pendentes}`);
    linhaInfo(doc, "Tarefas", `${tarefasConcluidas} de ${totalTarefas} concluídas`);
    doc.fillColor("#000").moveDown(1.5);

    // ===== Detalhamento por projeto =====
    secao(doc, "Detalhamento por Projeto");
    if (totalProjetos === 0) {
      doc.fontSize(10).font("Helvetica").fillColor(COR_CINZA).text("Nenhum projeto encontrado.");
    } else {
      projetos.forEach((p, i) => {
        const concluidasP = p.tarefas.filter((t) => t.status === "CONCLUIDO").length;
        const progressoP = p.tarefas.length > 0 ? Math.round((concluidasP / p.tarefas.length) * 100) : 0;

        doc.moveDown(0.3);
        doc.fontSize(12).font("Helvetica-Bold").fillColor("#000").text(`${i + 1}. ${p.titulo}`);
        doc
          .fontSize(9)
          .font("Helvetica")
          .fillColor(COR_CINZA)
          .text(
            `${labelModalidade(p.modalidade)} • ${labelStatusProjeto(p.status)} • Progresso: ${progressoP}% (${concluidasP}/${p.tarefas.length} tarefas)`,
          );
        doc.fontSize(9).fillColor(COR_CINZA).text(`Orientador: ${p.orientador.nomeCompleto} | Orientando: ${p.orientando.nomeCompleto}`);
      });
    }

    // ===== Rodapé =====
    doc.moveDown(2);
    y = doc.y;
    doc.save().moveTo(50, y).lineTo(doc.page.width - 50, y).lineWidth(1).strokeColor(COR_PRIMARIA).restore();
    doc.moveDown(0.5);
    doc
      .fontSize(8)
      .fillColor(COR_CINZA)
      .font("Helvetica")
      .text(
        `Documento gerado automaticamente pelo E-Project em ${new Date().toLocaleString("pt-BR")}`,
        { align: "center" },
      );

    doc.end();
  });
}

// ===== Helpers de layout =====

function secao(doc: PDFDocument.PDFDocument, titulo: string) {
  doc.moveDown(0.4);
  doc
    .fillColor(COR_PRIMARIA)
    .fontSize(13)
    .font("Helvetica-Bold")
    .text(titulo, { underline: false });
  // linha abaixo da seção
  let y = doc.y;
  doc.save().moveTo(50, y).lineTo(doc.page.width - 50, y).lineWidth(0.5).strokeColor(COR_SECUNDARIA).restore();
  doc.moveDown(0.4);
  doc.fillColor("#000");
}

function linhaInfo(doc: PDFDocument.PDFDocument, rotulo: string, valor: string) {
  doc
    .fontSize(10)
    .font("Helvetica-Bold")
    .fillColor("#000")
    .text(`${rotulo}: `, { continued: true });
  // Hack: o `continued` acima junta o próximo text()
  doc.font("Helvetica").fillColor(COR_CINZA).text(valor);
}

function formatDate(d: Date): string {
  return d.toLocaleDateString("pt-BR");
}

function formatDateTime(d: Date): string {
  return `${d.toLocaleDateString("pt-BR")} ${d.toLocaleTimeString("pt-BR", { hour: "2-digit", minute: "2-digit" })}`;
}

function labelModalidade(m: string): string {
  const map: Record<string, string> = {
    PIBIC: "PIBIC — Iniciação Científica",
    PIBITI: "PIBITI — Desenvolvimento Tecnológico",
    PIBEX: "PIBEX — Extensão",
    PACE: "PACE — Ações Consolidadas e Extensionistas",
    POS_GRADUACAO: "Pós-Graduação",
  };
  return map[m] ?? m;
}

function labelStatusProjeto(s: string): string {
  const map: Record<string, string> = {
    EM_ANDAMENTO: "Em Andamento",
    PENDENTE: "Pendente",
    CONCLUIDO: "Concluído",
    CANCELADO: "Cancelado",
  };
  return map[s] ?? s;
}

function labelStatusTarefa(s: string): string {
  const map: Record<string, string> = {
    A_FAZER: "A Fazer",
    EM_ANDAMENTO: "Em Andamento",
    CONCLUIDO: "Concluído",
  };
  return map[s] ?? s;
}

function labelAvaliacao(s: string): string {
  const map: Record<string, string> = {
    PENDENTE: "Aguardando Avaliação",
    APROVADA: "Aprovada",
    NECESSITA_AJUSTE: "Necessita Ajuste",
  };
  return map[s] ?? s;
}
