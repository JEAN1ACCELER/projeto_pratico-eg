import { Router } from "express";
import { notificacaoController } from "../application/controllers/notificacaoController.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = Router();

router.use(authMiddleware);

router.get("/", (req, res, next) => notificacaoController.listar(req, res, next).catch(next));
router.get("/nao-lidas", (req, res, next) => notificacaoController.contarNaoLidas(req, res, next).catch(next));
router.patch("/marcar-todas-lidas", (req, res, next) => notificacaoController.marcarTodasComoLidas(req, res, next).catch(next));
router.patch("/:id/lida", (req, res, next) => notificacaoController.marcarComoLida(req, res, next).catch(next));

export default router;
