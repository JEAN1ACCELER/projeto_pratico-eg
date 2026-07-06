import { Request, Response, NextFunction } from "express";
import { projetoService } from "../services/projetoService.js";

export const projetoController = {
  async listar(req: any, res: Response, _next: NextFunction) {
    const projetos = await projetoService.listar(req.userId, req.papel);
    res.json(projetos);
  },

  async criar(req: any, res: Response, _next: NextFunction) {
    const projeto = await projetoService.criar(req.body, req.userId);
    res.status(201).json(projeto);
  },

  async buscarPorId(req: any, res: Response, _next: NextFunction) {
    const projeto = await projetoService.buscarPorId(req.params.id);
    res.json(projeto);
  },

  async atualizar(req: any, res: Response, _next: NextFunction) {
    const projeto = await projetoService.atualizar(req.params.id, req.body, req.userId, req.papel);
    res.json(projeto);
  },

  async atualizarStatus(req: any, res: Response, _next: NextFunction) {
    const projeto = await projetoService.atualizarStatus(req.params.id, req.body.status);
    res.json(projeto);
  },

  async historico(req: any, res: Response, _next: NextFunction) {
    const projetos = await projetoService.listarHistorico(req.userId, req.papel);
    res.json(projetos);
  },

  async listarTodos(req: any, res: Response, _next: NextFunction) {
    const projetos = await projetoService.listarTodos();
    res.json(projetos);
  },
};
