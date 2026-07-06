import express from "express";
import cors from "cors";
import { env, logBootInfo } from "./config/env.js";
import { logger } from "./config/logger.js";
import { requestLogger } from "./middleware/requestLogger.js";
import { errorHandler } from "./middleware/errorHandler.js";
import authRoutes from "./routes/authRoutes.js";
import projetoRoutes from "./routes/projetoRoutes.js";
import tarefaRoutes from "./routes/tarefaRoutes.js";
import entregaRoutes from "./routes/entregaRoutes.js";
import reuniaoRoutes from "./routes/reuniaoRoutes.js";
import editalRoutes from "./routes/editalRoutes.js";
import notificacaoRoutes from "./routes/notificacaoRoutes.js";
import documentoRoutes from "./routes/documentoRoutes.js";

const app = express();

app.use(cors({ origin: env.corsOrigin }));
app.use(express.json({ limit: "10mb" }));
app.use(requestLogger);

// Health check
app.get("/", (_req, res) => {
  res.json({ name: "E-Project API", status: "ok", version: "1.0.0" });
});

// Rotas da API
app.use("/auth", authRoutes);
app.use("/projetos", projetoRoutes);
app.use("/tarefas", tarefaRoutes);
app.use("/entregas", entregaRoutes);
app.use("/reunioes", reuniaoRoutes);
app.use("/editais", editalRoutes);
app.use("/notificacoes", notificacaoRoutes);
app.use("/documentos", documentoRoutes);

// Error handler (deve ser o último middleware)
app.use(errorHandler);

app.listen(env.port, () => {
  logBootInfo();
  logger.info(`Rotas disponíveis: /auth /projetos /tarefas /entregas /reunioes /editais /notificacoes /documentos`);
});

export default app;
