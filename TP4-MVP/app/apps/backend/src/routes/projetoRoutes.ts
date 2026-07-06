import { Router } from "express";
import { projetoController } from "../application/controllers/projetoController.js";
import { authMiddleware, roleMiddleware } from "../middleware/authMiddleware.js";

const router = Router();

router.use(authMiddleware);

router.get("/", (req, res, next) => projetoController.listar(req, res, next).catch(next));
router.post("/", roleMiddleware("PROFESSOR", "ADMINISTRADOR"), (req, res, next) => projetoController.criar(req, res, next).catch(next));
router.get("/historico", (req, res, next) => projetoController.historico(req, res, next).catch(next));
router.get("/:id", (req, res, next) => projetoController.buscarPorId(req, res, next).catch(next));
router.put("/:id", (req, res, next) => projetoController.atualizar(req, res, next).catch(next));
router.patch("/:id/status", (req, res, next) => projetoController.atualizarStatus(req, res, next).catch(next));

export default router;
