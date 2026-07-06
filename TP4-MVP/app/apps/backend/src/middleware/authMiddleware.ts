import { Request, Response, NextFunction } from "express";
import { verifyToken } from "../infrastructure/auth/jwt.js";

export interface AuthRequest extends Request {
  userId?: string;
  papel?: string;
}

export function authMiddleware(req: AuthRequest, res: Response, next: NextFunction) {
  const header = req.headers.authorization;
  if (!header?.startsWith("Bearer ")) {
    return res.status(401).json({ error: "Token não fornecido" });
  }

  const token = header.substring(7);
  try {
    const payload = verifyToken(token);
    req.userId = payload.userId;
    req.papel = payload.papel;
    next();
  } catch {
    return res.status(401).json({ error: "Token inválido ou expirado" });
  }
}

/** Middleware that checks if user has one of the allowed roles. */
export function roleMiddleware(...roles: string[]) {
  return (req: AuthRequest, res: Response, next: NextFunction) => {
    if (!req.papel || !roles.includes(req.papel)) {
      return res.status(403).json({ error: "Acesso negado para este perfil" });
    }
    next();
  };
}
