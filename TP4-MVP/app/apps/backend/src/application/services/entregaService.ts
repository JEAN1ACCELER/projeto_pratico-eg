import { prisma } from "../../infrastructure/prisma.js";

export const entregaService = {
  async submeter(tarefaId: string, usuarioId: string, data: { comentarioAluno?: string }) {
    const tarefa = await prisma.tarefa.findUnique({
      where: { id: tarefaId },
      include: { projeto: { select: { orientandoId: true, orientadorId: true } } },
    });
    if (!tarefa) throw Object.assign(new Error("Tarefa não encontrada"), { status: 404 });
    if (tarefa.projeto.orientandoId !== usuarioId) {
      throw Object.assign(new Error("Somente o orientando pode submeter entregas"), { status: 403 });
    }

    // Check if delivery already exists
    const existing = await prisma.entrega.findUnique({ where: { tarefaId } });
    if (existing) throw Object.assign(new Error("Já existe uma entrega para esta tarefa"), { status: 409 });

    return prisma.entrega.create({
      data: {
        tarefaId,
        comentarioAluno: data.comentarioAluno,
        statusAvaliacao: "PENDENTE",
      },
    });
  },

  async avaliar(entregaId: string, feedbackOrientador: string, statusAvaliacao: string) {
    const entrega = await prisma.entrega.findUnique({
      where: { id: entregaId },
      include: { tarefa: { include: { projeto: { include: { orientandoId: true, titulo: true } } } } },
    });
    if (!entrega) throw Object.assign(new Error("Entrega não encontrada"), { status: 404 });

    const updated = await prisma.entrega.update({
      where: { id: entregaId },
      data: { feedbackOrientador, statusAvaliacao: statusAvaliacao as any, dataAvaliacao: new Date() },
    });

    // Notificar orientando sobre feedback
    if (entrega.tarefa.projeto.orientandoId) {
      await prisma.notificacao.create({
        data: {
          usuarioId: entrega.tarefa.projeto.orientandoId,
          tipo: "FEEDBACK_ENTREGA",
          conteudo: `Feedback recebido para "${entrega.tarefa.titulo}": ${statusAvaliacao === "APROVADA" ? "Aprovada ✓" : "Necessita ajuste"}`,
        },
      });
    }

    return updated;
  },

  async buscarPorTarefa(tarefaId: string) {
    return prisma.entrega.findUnique({ where: { tarefaId } });
  },
};
