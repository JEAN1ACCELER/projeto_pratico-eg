import { Router } from "express";
import { reuniaoController } from "../application/controllers/reuniaoController.js";
import { authMiddleware, roleMiddleware } from "../middleware/authMiddleware.js";

const router = Router();

router.use(authMiddleware);

router.get("/projeto/:projetoId", (req, res, next) => reuniaoController.listarPorProjeto(req, res, next).catch(next));
router.post("/projeto/:projetoId", roleMiddleware("PROFESSOR", "ADMINISTRADOR"), (req, res, next) => reuniaoController.criar(req, res, next).catch(next));
router.post("/:id/checkin", (req, res, next) => reuniaoController.checkIn(req, res, next).catch(next));
router.get("/:id/presencas", (req, res, next) => reuniaoController.listarPresencas(req, res, next).catch(next));

export default router;
