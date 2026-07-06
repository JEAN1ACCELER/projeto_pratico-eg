import { Request, Response, NextFunction } from "express";
import { entregaService } from "../services/entregaService.js";

export const entregaController = {
  async submeter(req: any, res: Response, _next: NextFunction) {
    const entrega = await entregaService.submeter(req.params.tarefaId, req.userId, req.body);
    res.status(201).json(entrega);
  },

  async avaliar(req: any, res: Response, _next: NextFunction) {
    const entrega = await entregaService.avaliar(req.params.id, req.body.feedbackOrientador, req.body.statusAvaliacao);
    res.json(entrega);
  },

  async buscarPorTarefa(req: any, res: Response, _next: NextFunction) {
    const entrega = await entregaService.buscarPorTarefa(req.params.tarefaId);
    res.json(entrega ?? null);
  },
};
