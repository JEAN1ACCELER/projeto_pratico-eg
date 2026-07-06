import { Request, Response, NextFunction } from "express";
import { editalService } from "../services/editalService.js";

export const editalController = {
  async listar(req: any, res: Response, _next: NextFunction) {
    const editais = await editalService.listar();
    res.json(editais);
  },

  async listarTodos(req: any, res: Response, _next: NextFunction) {
    const editais = await editalService.listarTodos();
    res.json(editais);
  },

  async criar(req: any, res: Response, _next: NextFunction) {
    const edital = await editalService.criar(req.body);
    res.status(201).json(edital);
  },

  async buscarPorId(req: any, res: Response, _next: NextFunction) {
    const edital = await editalService.buscarPorId(req.params.id);
    res.json(edital);
  },

  async encerrar(req: any, res: Response, _next: NextFunction) {
    const edital = await editalService.encerrar(req.params.id);
    res.json(edital);
  },
};
