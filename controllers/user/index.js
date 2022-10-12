import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

export const findAll = async (req, res) => {
  try {
    const users = await prisma.User.findMany();
    return res.status(200).json({
      users,
    });
  } catch (err) {
    console.log(err);
  }
};
export const getUser = async (req,res) => { 
      try { 
     const { id } = req.body;
     const user = await prisma.user.findFirst({ 
        where: { 
            id: id, 
        }, 
         select: { 
           username: true,
        }, 
       }); 
        res.json({ 
          success: true, 
          data: user, 
        }); 
      } catch (error) { 
        console.log(error); 
        res.status(500).send({ 
          success: false, 
          message: 'Something went wrong', 
        }); 
        return false; 
     } 
    };

export const create = async (req , res) => {
  try {
    console.log(req.body);
    //we gonna search the client inside our bd
    let user = await prisma.user.findFirst({
      where: {
        username: req.body.username,
      },
    });
    console.log("i am searching the user");
    //if we did found it we logout
    if (user) {
      console.log("user exist already");
      return res.status(401).json({
        success: false,
        message: "User already exists",
      });
    }
    console.log("usernot found");
    //now we have to create a new User
    //console.log(req.body)
    if ("idUser" in req.body) {
      delete req.body.idUser;
    }
    //console.log("m here now")
    let newUser = await prisma.user.create({
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