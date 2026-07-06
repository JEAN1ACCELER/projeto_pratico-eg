import { Router } from "express";
import { editalController } from "../application/controllers/editalController.js";
import { authMiddleware, roleMiddleware } from "../middleware/authMiddleware.js";

const router = Router();

router.use(authMiddleware);

router.get("/", (req, res, next) => editalController.listar(req, res, next).catch(next));
router.post("/", roleMiddleware("ADMINISTRADOR"), (req, res, next) => editalController.criar(req, res, next).catch(next));
router.get("/:id", (req, res, next) => editalController.buscarPorId(req, res, next).catch(next));
router.patch("/:id/encerrar", roleMiddleware("ADMINISTRADOR"), (req, res, next) => editalController.encerrar(req, res, next).catch(next));

export default router;
