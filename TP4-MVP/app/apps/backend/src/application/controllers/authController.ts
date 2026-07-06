import { Request, Response, NextFunction } from "express";
import { authService } from "../services/authService.js";

export const authController = {
  async register(req: Request, res: Response, _next: NextFunction) {
    const result = await authService.register(req.body);
    res.status(201).json(result);
  },

  async login(req: Request, res: Response, _next: NextFunction) {
    const { emailInstitucional, senha } = req.body;
    const result = await authService.login(emailInstitucional, senha);
    res.json(result);
  },

  async getMe(req: any, res: Response, _next: NextFunction) {
    const usuario = await authService.getMe(req.userId);
    res.json(usuario);
  },
};
