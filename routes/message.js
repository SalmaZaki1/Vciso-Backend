import { Router } from "express";
import { addMessage,getMessage } from "../controllers/message/index.js";

const router  =  Router();
router.post('/addMessage', addMessage);
router.get("/:chatId", getMessage);

export default router;