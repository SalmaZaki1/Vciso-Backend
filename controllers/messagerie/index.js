import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();



export const createMsg = async(req, res) => {
  //  const chat = new Chat({
   //     member: [req.body.senderId, req.body.receiverId]
 //   });
//const result = await prisma.Chat.create();
//res.status(200).json(result);
   /* try {
        const chat = await prisma.Chat.create({
            data: {
                senderId: req.body.senderId,
                receiverId: req.body.receiverId,
            }
        });
        res.status(200).json({success: true, role: "chat", chat });-*/
    const chat = new prisma.Chat({
                 member: [req.body.senderId, req.body.receiverId]
    });
    try {
        const result = await prisma.chat.create();
        res.status(200).json(result);
    } catch (error) {
        res.status(500).json(error);
}
};

export const userMsg = async (req, res) => {
    try {
        const chat = await prisma.Chat.findUnique({
            members : {$in: [req.parms.userId]}
        })
        res.status(200).json(chat)

    } catch (error) {
        res.status(500).json(error);
    }
}

export const findChat = async (req, res) => {
    try {
        const chat = await prisma.Chat.findFirst({
            members: {$all : [req.params.firstId, req.params.secondId]}       
    })
        res.status(200).json(chat);
    } catch (error) {
        res.status(500).json(error);
 }
}