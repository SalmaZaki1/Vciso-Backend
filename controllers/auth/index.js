import { PrismaClient } from "@prisma/client";
import jwt from "jsonwebtoken";
const prisma = new PrismaClient();

export const login = async (req, res) => {
  try {
    const { email, password } = req.body;
    console.log(email, password);
    if (!email || !password) {
      return res.status(400).json({ message: "Please enter all fields" });
    }
    const user = await prisma.user.findUnique({
      where: {
        email,
      },
      include: {
        client: true,
        expert: true,
        admin: true,
      },
    });
    if (!user) {
      return res.status(400).json({ message: "User does not exist" });
    }
    if (user.password !== password) {
      return res.status(400).json({ message: "Invalid credentials" });
    }
    const token = jwt.sign(
      { id: user.idUser, role: user.role },
      process.env.JWT_SECRET,
      { expiresIn: 3600 }
    );
    res.json({
      token: token,
      user: {
        id: user.idUser,
        name: user.name,
        email: user.email,
        role: user.type,
      },
    });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Server error" });
  }
};

export const signup = async (req, res) => {
  try {
    const data = req.body;
    const userByName = await prisma.User.findFirst({
      where: {
        username: data.username,
      },
    });
    const userByEmail = await prisma.User.findFirst({
      where: {
        email: data.email,
      },
    });
    let dataToSave = {
      name: data.name,
      email: data.email,
      username: data.username,
      password: data.password,
      firstname: data.firstname,
      lastname: data.lastname,
      sexe: data.sexe,
      age: data.age,
      city: data.city,
      telephone: data.telephone,
      type: data.type,
    };

    if (userByName || userByEmail) {
      return res
        .status(400)
        .json({ success: false, message: "User already exists" });
    }
    const user = await prisma.User.create({
      data: dataToSave,
    });
    switch (data.type) {
      case "Client":
        const client = await prisma.Client.create({
          data: {
            user: {
              connect: {
                idUser: user.idUser,
              },
            },
          },
        });
        res.status(200).json({
          success: true,
          message: "Client created",
          role: "Client",
          user: {
            ...user,
            client,
          },
        });
        break;
      case "Expert":
        const expert = await prisma.Expert.create({
          data: {
            user: {
              connect: {
                idUser: user.idUser,
              },
            },
          },
        });
        res.status(200).json({
          success: true,
          message: "Expert created",
          role: "Expert",
          user: {
            ...user,
            expert,
          },
        });
        break;
      case "Admin":
        const admin = await prisma.Admin.create({
          data: {
            user: {
              connect: {
                idUser: user.idUser,
              },
            },
          },
        });
        res.status(200).json({
          success: true,
          message: "Admin created",
          role: "Admin",
          user: {
            ...user,
            admin,
          },
        });
        break;
      default:
        res
          .status(400)
          .json({ success: false, message: "User type not found" });
        break;
    }
  } catch (err) {
    console.log(err);
    return res.status(400).json({ success: false });
  }
};
