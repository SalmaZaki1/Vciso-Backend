import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

export const findAll = async (req, res) => {
  try {
    const clients = await prisma.Client.findMany();
    return res.status(200).json({
      clients,
    });
  } catch (err) {
    console.log(err);
  }
};

export const create = async (req, res) => {
  try {
    console.log(req.body);
    //we gonna search the client inside our bd
    let client = await prisma.user.findFirst({
      where: {
        username: req.body.username,
      },
    });
    console.log("i am searching the client");
    //if we did found it we logout
    if (client) {
      console.log("client exist already");
      return res.status(401).json({
        success: false,
        message: "User already exists",
      });
    }
    console.log("Client not found");
    //now we have to create a new client
    //console.log(req.body)
    if ("idClient" in req.body) {
      delete req.body.idClient;
    }
    //console.log("m here now")
    let newClient = await prisma.user.create({
      data: req.body,
    });
    console.log("m created successfully");
    res.status(200).json({
      success: true,
      message: "User created successfully",
    });
  } catch (err) {
    console.log(err);
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};
