import { Router } from "express";
import { entregaController } from "../application/controllers/entregaController.js";
import { authMiddleware, roleMiddleware } from "../middleware/authMiddleware.js";

const router = Router();

router.use(authMiddleware);

router.get("/tarefa/:tarefaId", (req, res, next) => entregaController.buscarPorTarefa(req, res, next).catch(next));
router.post("/tarefa/:tarefaId", roleMiddleware("ALUNO"), (req, res, next) => entregaController.submeter(req, res, next).catch(next));
router.patch("/:id/avaliar", roleMiddleware("PROFESSOR", "ADMINISTRADOR"), (req, res, next) => entregaController.avaliar(req, res, next).catch(next));

export default router;
