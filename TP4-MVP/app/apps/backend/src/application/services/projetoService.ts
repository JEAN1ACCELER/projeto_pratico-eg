import { prisma } from "../../infrastructure/prisma.js";

export const projetoService = {
  async listar(usuarioId: string, papel: string) {
    const where: any = {};
    if (papel === "PROFESSOR") where.orientadorId = usuarioId;
    else if (papel === "ALUNO") where.orientandoId = usuarioId;
    // ADMIN vê todos

    const projetos = await prisma.projeto.findMany({
      where,
      include: {
        orientador: { select: { id: true, nomeCompleto: true, emailInstitucional: true } },
        orientando: { select: { id: true, nomeCompleto: true, emailInstitucional: true } },
        _count: { select: { tarefas: true } },
        tarefas: { select: { status: true } },
      },
      orderBy: { createdAt: "desc" },
    });

    return projetos.map((p) => ({
      ...p,
      progresso: calcularProgresso(p.tarefas),
      totalTarefas: p.tarefas.length,
      tarefasConcluidas: p.tarefas.filter((t) => t.status === "CONCLUIDO").length,
    }));
  },

  async criar(data: any, orientadorId: string) {
    return prisma.projeto.create({
      data: {
        ...data,
        orientadorId,
        status: "EM_ANDAMENTO",
      },
    });
  },

  async buscarPorId(id: string) {
    const projeto = await prisma.projeto.findUnique({
      where: { id },
      include: {
        orientador: { select: { id: true, nomeCompleto: true, emailInstitucional: true } },
        orientando: { select: { id: true, nomeCompleto: true, emailInstitucional: true } },
        tarefas: {
          orderBy: { createdAt: "desc" },
          include: { entrega: true },
        },
        reunioes: { orderBy: { dataHora: "desc" }, include: { presencas: { include: { usuario: { select: { nomeCompleto: true } } } } } },
      },
    });
    if (!projeto) throw Object.assign(new Error("Projeto não encontrado"), { status: 404 });
    return projeto;
  },

  async atualizar(id: string, data: any, usuarioId: string, papel: string) {
    const projeto = await prisma.projeto.findUnique({ where: { id } });
    if (!projeto) throw Object.assign(new Error("Projeto não encontrado"), { status: 404 });
    if (papel !== "ADMINISTRADOR" && projeto.orientadorId !== usuarioId) {
      throw Object.assign(new Error("Sem permissão para editar este projeto"), { status: 403 });
    }
    return prisma.projeto.update({ where: { id }, data });
  },

  async atualizarStatus(id: string, status: string) {
    return prisma.projeto.update({ where: { id }, data: { status } });
  },

  async listarHistorico(usuarioId: string, papel: string) {
    const where: any = { status: { in: ["CONCLUIDO", "CANCELADO"] } };
    if (papel === "PROFESSOR") where.orientadorId = usuarioId;
    else if (papel === "ALUNO") where.orientandoId = usuarioId;

    return prisma.projeto.findMany({
      where,
      include: {
        orientador: { select: { nomeCompleto: true } },
        orientando: { select: { nomeCompleto: true } },
        _count: { select: { tarefas: true } },
      },
      orderBy: { updatedAt: "desc" },
    });
  },

  async listarTodos() {
    return prisma.projeto.findMany({
      include: {
        orientador: { select: { nomeCompleto: true } },
        orientando: { select: { nomeCompleto: true } },
        _count: { select: { tarefas: true } },
      },
      orderBy: { createdAt: "desc" },
    });
  },
};

function calcularProgresso(tarefas: Array<{ status: string }>): number {
  if (tarefas.length === 0) return 0;
  return Math.round((tarefas.filter((t) => t.status === "CONCLUIDO").length / tarefas.length) * 100);
}
