import { Router } from "express";
import { documentoController } from "../application/controllers/documentoController.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = Router();

router.use(authMiddleware);

// Relatório consolidado de TODOS os projetos do usuário (logado)
router.get("/relatorio-geral", (req, res, next) => documentoController.gerarRelatorioGeral(req, res, next).catch(next));
// Relatório detalhado de UM projeto
router.get("/relatorio/:projetoId", (req, res, next) => documentoController.gerarRelatorio(req, res, next).catch(next));

export default router;
