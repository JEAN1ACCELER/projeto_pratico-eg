import { prisma } from "../../infrastructure/prisma.js";

export const editalService = {
  async listar() {
    return prisma.edital.findMany({
      where: { ativo: true },
      orderBy: { dataPublicacao: "desc" },
    });
  },

  async listarTodos() {
    return prisma.edital.findMany({ orderBy: { dataPublicacao: "desc" } });
  },

  async criar(data: any) {
    return prisma.edital.create({ data });
  },

  async buscarPorId(id: string) {
    const edital = await prisma.edital.findUnique({ where: { id } });
    if (!edital) throw Object.assign(new Error("Edital não encontrado"), { status: 404 });
    return edital;
  },

  async encerrar(id: string) {
    const edital = await prisma.edital.update({ where: { id }, data: { ativo: false } });
    return edital;
  },
};
