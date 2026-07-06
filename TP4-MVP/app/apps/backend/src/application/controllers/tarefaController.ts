import { Request, Response, NextFunction } from "express";
import { tarefaService } from "../services/tarefaService.js";

export const tarefaController = {
  async listarPorProjeto(req: any, res: Response, _next: NextFunction) {
    const tarefas = await tarefaService.listarPorProjeto(req.params.projetoId);
    res.json(tarefas);
  },

  async criar(req: any, res: Response, _next: NextFunction) {
    const tarefa = await tarefaService.criar(req.body, req.params.projetoId);
    res.status(201).json(tarefa);
  },

  async buscarPorId(req: any, res: Response, _next: NextFunction) {
    const tarefa = await tarefaService.buscarPorId(req.params.id);
    res.json(tarefa);
  },

  async atualizarStatus(req: any, res: Response, _next: NextFunction) {
    const tarefa = await tarefaService.atualizarStatus(req.params.id, req.body.status);
    res.json(tarefa);
  },

  async atualizar(req: any, res: Response, _next: NextFunction) {
    const tarefa = await tarefaService.atualizar(req.params.id, req.body);
    res.json(tarefa);
  },

  async deletar(req: any, res: Response, _next: NextFunction) {
    await tarefaService.deletar(req.params.id);
    res.json({ message: "Tarefa removida" });
  },
};
