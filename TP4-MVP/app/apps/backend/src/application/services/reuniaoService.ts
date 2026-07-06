import { prisma } from "../../infrastructure/prisma.js";

export const reuniaoService = {
  async listarPorProjeto(projetoId: string) {
    return prisma.reuniao.findMany({
      where: { projetoId },
      include: { presencas: { include: { usuario: { select: { id: true, nomeCompleto: true } } } } },
      orderBy: { dataHora: "desc" },
    });
  },

  async criar(data: { dataHora: Date; local?: string; resumo?: string }, projetoId: string) {
    const pin = String(Math.floor(1000 + Math.random() * 9000));
    return prisma.reuniao.create({
      data: { ...data, projetoId, pinCheckIn: pin },
    });
  },

  async registrarCheckIn(reuniaoId: string, usuarioId: string, pin: string) {
    const reuniao = await prisma.reuniao.findUnique({ where: { id: reuniaoId } });
    if (!reuniao) throw Object.assign(new Error("Reunião não encontrada"), { status: 404 });
    if (reuniao.pinCheckIn !== pin) throw Object.assign(new Error("PIN inválido"), { status: 401 });

    // Check duplicate
    const existing = await prisma.presenca.findUnique({ where: { reuniaoId_usuarioId: { reuniaoId, usuarioId } } });
    if (existing) throw Object.assign(new Error("Check-in já registrado para esta reunião"), { status: 409 });

    return prisma.presenca.create({ data: { reuniaoId, usuarioId } });
  },

  async listarPresencas(reuniaoId: string) {
    return prisma.presenca.findMany({
      where: { reuniaoId },
      include: { usuario: { select: { id: true, nomeCompleto: true, emailInstitucional: true } } },
      orderBy: { createdAt: "asc" },
    });
  },
};
