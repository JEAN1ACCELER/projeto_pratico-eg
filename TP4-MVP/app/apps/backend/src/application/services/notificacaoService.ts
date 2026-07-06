import { prisma } from "../../infrastructure/prisma.js";

export const notificacaoService = {
  async listarPorUsuario(usuarioId: string) {
    return prisma.notificacao.findMany({
      where: { usuarioId },
      orderBy: [{ lida: "asc" }, { dataEnvio: "desc" }],
    });
  },

  async criar(usuarioId: string, tipo: string, conteudo: string) {
    return prisma.notificacao.create({ data: { usuarioId, tipo: tipo as any, conteudo } });
  },

  async marcarComoLida(id: string) {
    const notif = await prisma.notificacao.findUnique({ where: { id } });
    if (!notif) throw Object.assign(new Error("Notificação não encontrada"), { status: 404 });
    return prisma.notificacao.update({ where: { id }, data: { lida: true } });
  },

  async marcarTodasComoLidas(usuarioId: string) {
    return prisma.notificacao.updateMany({ where: { usuarioId, lida: false }, data: { lida: true } });
  },

  async contarNaoLidas(usuarioId: string) {
    return prisma.notificacao.count({ where: { usuarioId, lida: false } });
  },
};
