import { Router } from "express";
import { getUser, findAll } from "../controllers/user/index.js";

const router = Router();
router.get("/:id", getUser);
router.get("/", findAll);
export default router;
