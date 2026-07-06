import jwt, { SignOptions } from "jsonwebtoken";
import { env } from "../../config/env.js";

export interface JwtPayload {
  userId: string;
  papel: string;
}

export function generateToken(userId: string, papel: string): string {
  const options: SignOptions = { expiresIn: env.jwtExpiresIn as any };
  return jwt.sign({ userId, papel }, env.jwtSecret, options);
}

export function verifyToken(token: string): JwtPayload {
  return jwt.verify(token, env.jwtSecret) as JwtPayload;
}
