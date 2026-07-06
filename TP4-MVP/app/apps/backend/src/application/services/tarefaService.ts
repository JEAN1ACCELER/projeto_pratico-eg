import { prisma } from "../../infrastructure/prisma.js";

export const tarefaService = {
  async listarPorProjeto(projetoId: string) {
    return prisma.tarefa.findMany({
      where: { projetoId },
      include: { entrega: true },
      orderBy: { createdAt: "desc" },
    });
  },

  async criar(data: any, projetoId: string) {
    const projeto = await prisma.projeto.findUnique({ where: { id: projetoId }, include: { orientando: true } });
    if (!projeto) throw Object.assign(new Error("Projeto não encontrado"), { status: 404 });

    const tarefa = await prisma.tarefa.create({
      data: { ...data, projetoId },
    });

    // Notificar orientando sobre nova tarefa
    if (projeto.orientandoId) {
      await prisma.notificacao.create({
        data: {
          usuarioId: projeto.orientandoId,
          tipo: "NOVA_TAREFA",
          conteudo: `Nova tarefa atribuída: "${tarefa.titulo}" no projeto "${projeto.titulo}"`,
        },
      });
    }

    return tarefa;
  },

  async atualizarStatus(id: string, status: string) {
    const data: any = { status };
    if (status === "CONCLUIDO") data.dataConclusao = new Date();
    return prisma.tarefa.update({ where: { id }, data });
  },

  async buscarPorId(id: string) {
    const tarefa = await prisma.tarefa.findUnique({
      where: { id },
      include: { projeto: { select: { titulo: true, orientadorId: true, orientandoId: true } }, entrega: true },
    });
    if (!tarefa) throw Object.assign(new Error("Tarefa não encontrada"), { status: 404 });
    return tarefa;
  },

  async atualizar(id: string, data: any) {
    return prisma.tarefa.update({ where: { id }, data });
  },

  async deletar(id: string) {
    return prisma.tarefa.delete({ where: { id } });
  },
};
