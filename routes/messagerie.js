import { Router } from "express";
import { createMsg,userMsg,findChat } from "../controllers/messagerie/index.js";

const router = Router();
router.post("/create", createMsg);
router.get("/:idUser", userMsg);
router.get("/find/:firstId/:secondId", findChat)
export default router;