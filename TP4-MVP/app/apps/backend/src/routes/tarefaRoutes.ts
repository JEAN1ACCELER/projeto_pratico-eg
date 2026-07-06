import { Router } from "express";
import { tarefaController } from "../application/controllers/tarefaController.js";
import { authMiddleware, roleMiddleware } from "../middleware/authMiddleware.js";

const router = Router();

router.use(authMiddleware);

router.get("/projeto/:projetoId", (req, res, next) => tarefaController.listarPorProjeto(req, res, next).catch(next));
router.post("/projeto/:projetoId", roleMiddleware("PROFESSOR", "ADMINISTRADOR"), (req, res, next) => tarefaController.criar(req, res, next).catch(next));
router.get("/:id", (req, res, next) => tarefaController.buscarPorId(req, res, next).catch(next));
router.patch("/:id/status", (req, res, next) => tarefaController.atualizarStatus(req, res, next).catch(next));
router.put("/:id", (req, res, next) => tarefaController.atualizar(req, res, next).catch(next));
router.delete("/:id", (req, res, next) => tarefaController.deletar(req, res, next).catch(next));

export default router;
