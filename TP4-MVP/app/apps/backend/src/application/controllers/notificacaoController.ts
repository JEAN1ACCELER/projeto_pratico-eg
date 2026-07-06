import { Request, Response, NextFunction } from "express";
import { notificacaoService } from "../services/notificacaoService.js";

export const notificacaoController = {
  async listar(req: any, res: Response, _next: NextFunction) {
    const notificacoes = await notificacaoService.listarPorUsuario(req.userId);
    res.json(notificacoes);
  },

  async marcarComoLida(req: any, res: Response, _next: NextFunction) {
    await notificacaoService.marcarComoLida(req.params.id);
    res.json({ message: "Notificação marcada como lida" });
  },

  async marcarTodasComoLidas(req: any, res: Response, _next: NextFunction) {
    await notificacaoService.marcarTodasComoLidas(req.userId);
    res.json({ message: "Todas as notificações marcadas como lidas" });
  },

  async contarNaoLidas(req: any, res: Response, _next: NextFunction) {
    const count = await notificacaoService.contarNaoLidas(req.userId);
    res.json({ count });
  },
};
