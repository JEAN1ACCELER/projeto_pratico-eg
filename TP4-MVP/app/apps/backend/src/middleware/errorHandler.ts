import { Request, Response, NextFunction } from "express";
import { logger } from "../config/logger.js";

export function errorHandler(err: Error, _req: Request, res: Response, _next: NextFunction) {
  const status = (err as any).status ?? 500;
  logger.error(`[${status}] ${err.message}`, err.stack ? { stack: err.stack } : undefined);

  res.status(status).json({
    error: status === 500 ? "Erro interno do servidor" : err.message,
  });
}
