import { Router } from "express";
import { authController } from "../application/controllers/authController.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = Router();

router.post("/register", (req, res, next) => authController.register(req, res, next).catch(next));
router.post("/login", (req, res, next) => authController.login(req, res, next).catch(next));
router.get("/me", authMiddleware, (req, res, next) => authController.getMe(req, res, next).catch(next));

export default router;
