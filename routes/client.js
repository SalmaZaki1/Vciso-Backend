import { Router } from "express";
import {findAll,create}  from "../controllers/client/index.js";

const router = Router(); 
router.get("/findAll",findAll);
router.post("/create",create);

export default router;