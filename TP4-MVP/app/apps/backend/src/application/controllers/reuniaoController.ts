import { Request, Response, NextFunction } from "express";
import { reuniaoService } from "../services/reuniaoService.js";

export const reuniaoController = {
  async listarPorProjeto(req: any, res: Response, _next: NextFunction) {
    const reunioes = await reuniaoService.listarPorProjeto(req.params.projetoId);
    res.json(reunioes);
  },

  async criar(req: any, res: Response, _next: NextFunction) {
    const reuniao = await reuniaoService.criar(req.body, req.params.projetoId);
    res.status(201).json(reuniao);
  },

  async checkIn(req: any, res: Response, _next: NextFunction) {
    const presenca = await reuniaoService.registrarCheckIn(req.params.id, req.userId, req.body.pin);
    res.status(201).json(presenca);
  },

  async listarPresencas(req: any, res: Response, _next: NextFunction) {
    const presencas = await reuniaoService.listarPresencas(req.params.id);
    res.json(presencas);
  },
};
