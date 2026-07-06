import { PrismaClient } from "@prisma/client";
import { env } from "../config/env.js";

/** Singleton do Prisma Client (Camada de Infraestrutura - acesso ao PostgreSQL). */
export const prisma = new PrismaClient({
  log: env.nodeEnv === "development" ? ["warn", "error"] : ["error"],
});
