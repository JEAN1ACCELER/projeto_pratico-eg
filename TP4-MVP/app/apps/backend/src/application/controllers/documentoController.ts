import { Request, Response, NextFunction } from "express";
import { documentoService } from "../services/documentoService.js";

export const documentoController = {
  async gerarRelatorio(req: any, res: Response, _next: NextFunction) {
    const buffer = await documentoService.gerarRelatorio(req.params.projetoId);
    res.setHeader("Content-Type", "application/pdf");
    res.setHeader("Content-Disposition", 'attachment; filename="relatorio-projeto.pdf"');
    res.send(buffer);
  },

  async gerarRelatorioGeral(req: any, res: Response, _next: NextFunction) {
    // req.userId e req.papel são populados pelo authMiddleware
    const buffer = await documentoService.gerarRelatorioGeral(req.userId, req.papel);
    res.setHeader("Content-Type", "application/pdf");
    res.setHeader("Content-Disposition", 'attachment; filename="relatorio-geral.pdf"');
    res.send(buffer);
  },
};
