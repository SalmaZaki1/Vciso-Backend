import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

export const addMessage = async ( req,res ) => {
  const {IdChat, senderId, message} = req.body;
  const msg =  new Message({IdChat, senderId, message});
 try {
    const rslt = await prisma.message.create();
    res.status(200).json(rslt);

 } catch (error){
    res.status(500).json(error);
 }
}

export const getMessage = async (req,res) => {
    const {IdChat} = req.params;
    try  {
        const rslt = await prisma.Message.findById({IdChat});
        res.status(200).json(rslt);
    } catch (error) {
        res.status(500).json(error);
    }
}