import dotenv from "dotenv";
import { logger } from "./logger.js";

dotenv.config();

/** Configurações de ambiente centralizadas e validadas. */
export const env = {
  databaseUrl: process.env.DATABASE_URL ?? "postgresql://eproject:eproject@localhost:5432/eproject?schema=public",
  jwtSecret: process.env.JWT_SECRET ?? "dev-secret-trocar-em-producao",
  jwtExpiresIn: process.env.JWT_EXPIRES_IN ?? "7d",
  port: Number(process.env.PORT ?? 3000),
  corsOrigin: (process.env.CORS_ORIGIN ?? "*").split(",").map((s) => s.trim()),
  nodeEnv: process.env.NODE_ENV ?? "development",
};

export function logBootInfo() {
  logger.info(`E-Project API inicializando | porta=${env.port} | env=${env.nodeEnv}`);
}
