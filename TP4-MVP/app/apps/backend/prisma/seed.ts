import { PrismaClient, Papel, Modalidade, StatusProjeto, StatusTarefa, StatusAvaliacao } from "@prisma/client";
import bcrypt from "bcrypt";

const prisma = new PrismaClient();

/**
 * Popula o banco com dados de demonstração do E-Project:
 * - 1 Administrador, 1 Professor orientador, 1 Aluno orientando
 * - 2 Projetos (PIBIC e PACE) com tarefas e uma entrega
 * - 2 Editais de exemplo
 */
async function main() {
  const senha = await bcrypt.hash("senha123", 10);

  const admin = await prisma.usuario.upsert({
    where: { emailInstitucional: "admin@ufam.edu.br" },
    update: {},
    create: {
      nomeCompleto: "Carlos Mendonça",
      emailInstitucional: "admin@ufam.edu.br",
      hashSenha: senha,
      papel: Papel.ADMINISTRADOR,
      matricula: "SIAPE-00001",
      departamento: "DCC",
      ativo: true,
      aceiteTermos: true,
      aceitePrivacidade: true,
    },
  });

  const professor = await prisma.usuario.upsert({
    where: { emailInstitucional: "victor.antunes@ufam.edu.br" },
    update: {},
    create: {
      nomeCompleto: "Victor Antunes",
      emailInstitucional: "victor.antunes@ufam.edu.br",
      hashSenha: senha,
      papel: Papel.PROFESSOR,
      matricula: "SIAPE-10001",
      departamento: "IComp",
      ativo: true,
      aceiteTermos: true,
      aceitePrivacidade: true,
    },
  });

  const aluno = await prisma.usuario.upsert({
    where: { emailInstitucional: "ana.beatriz@ufam.edu.br" },
    update: {},
    create: {
      nomeCompleto: "Ana Beatriz",
      emailInstitucional: "ana.beatriz@ufam.edu.br",
      hashSenha: senha,
      papel: Papel.ALUNO,
      matricula: "2155-0001",
      ativo: true,
      aceiteTermos: true,
      aceitePrivacidade: true,
    },
  });

  const projetoPibic = await prisma.projeto.upsert({
    where: { id: "projeto-pibic-demo" },
    update: {},
    create: {
      id: "projeto-pibic-demo",
      titulo: "Análise de Desempenho de Redes Acadêmicas",
      modalidade: Modalidade.PIBIC,
      status: StatusProjeto.EM_ANDAMENTO,
      dataInicio: new Date("2026-03-01"),
      dataTermino: new Date("2027-02-28"),
      resumo: "Estudo experimental sobre desempenho de redes em campi universitários.",
      orientadorId: professor.id,
      orientandoId: aluno.id,
    },
  });

  const projetoPace = await prisma.projeto.upsert({
    where: { id: "projeto-pace-demo" },
    update: {},
    create: {
      id: "projeto-pace-demo",
      titulo: "Aplicativo de Apoio à Orientação Acadêmica",
      modalidade: Modalidade.PACE,
      status: StatusProjeto.EM_ANDAMENTO,
      dataInicio: new Date("2026-04-01"),
      dataTermino: new Date("2026-12-15"),
      resumo: "Desenvolvimento de uma plataforma para gestão de orientandos.",
      orientadorId: professor.id,
      orientandoId: aluno.id,
    },
  });

  const tarefa1 = await prisma.tarefa.upsert({
    where: { id: "tarefa-revisao-demo" },
    update: {},
    create: {
      id: "tarefa-revisao-demo",
      titulo: "Revisão da Literatura",
      descricao: "Levantar referências sobre QoS em redes de campus.",
      prazo: new Date("2026-07-30"),
      status: StatusTarefa.EM_ANDAMENTO,
      projetoId: projetoPibic.id,
    },
  });

  await prisma.tarefa.upsert({
    where: { id: "tarefa-coleta-demo" },
    update: {},
    create: {
      id: "tarefa-coleta-demo",
      titulo: "Coleta de Dados de Tráfego",
      descricao: "Capturar amostras de tráfego em horários de pico.",
      prazo: new Date("2026-08-15"),
      status: StatusTarefa.A_FAZER,
      projetoId: projetoPibic.id,
    },
  });

  await prisma.entrega.upsert({
    where: { tarefaId: tarefa1.id },
    update: {},
    create: {
      tarefaId: tarefa1.id,
      comentarioAluno: "Primeira versão da revisão. Aguardo orientação sobre incluir IEEE 802.1X.",
      statusAvaliacao: StatusAvaliacao.PENDENTE,
    },
  });

  await prisma.reuniao.upsert({
    where: { id: "reuniao-demo" },
    update: {},
    create: {
      id: "reuniao-demo",
      projetoId: projetoPibic.id,
      dataHora: new Date("2026-07-10T14:00:00"),
      local: "Sala 301 - IComp",
      resumo: "Definição do cronograma de experimentos.",
      pinCheckIn: "1234",
    },
  });

  await prisma.edital.upsert({
    where: { id: "edital-pibic-demo" },
    update: {},
    create: {
      id: "edital-pibic-demo",
      titulo: "Edital PIBIC 2026/2027",
      descricao: "Inscrições abertas para bolsas de Iniciação Científica.",
      modalidade: Modalidade.PIBIC,
      fonte: "PROPESP/UFAM",
      linkOriginal: "https://propesp.ufam.edu.br/pibic",
      dataEncerramento: new Date("2026-09-30"),
    },
  });

  await prisma.edital.upsert({
    where: { id: "edital-pace-demo" },
    update: {},
    create: {
      id: "edital-pace-demo",
      titulo: "Edital PACE 2026",
      descricao: "Programa de Ações Consolidadas e Extensionistas.",
      modalidade: Modalidade.PACE,
      fonte: "PROEXT/UFAM",
      linkOriginal: "https://proext.ufam.edu.br/pace",
      dataEncerramento: new Date("2026-08-31"),
    },
  });

  console.log("Seed concluído:");
  console.log(`  Admin:     ${admin.emailInstitucional}`);
  console.log(`  Professor: ${professor.emailInstitucional}`);
  console.log(`  Aluno:     ${aluno.emailInstitucional}`);
  console.log("  Senha padrão: senha123");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
