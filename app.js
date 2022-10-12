import clientRoutes from "./routes/client.js";
import userRoutes from "./routes/user.js";
import authRoutes from "./routes/auth.js";
import messagerieRoutes from "./routes/messagerie.js";
import messageRoutes from "./routes/message.js";

import express from "express";
import cors from "cors"; //to handle socket.io issues
import http from "http";
import { Server} from "socket.io";//i did import an interface a class called Server 

const app = express();
app.use(cors());

//i did create my server i did generat it
const server = http.createServer(app);
//here we do  instanciate the Server i did import from socket.io library
//well its a connection that we ll be isablishing 
//so we do connect our socket.io with the express server that i did created
const io = new Server(server,{
   cors: {
          origin: "http://localhost:3000", //here m telling my server which url its gonna call our socket.io which is the react url
          methods:["GET", "POST"], //which methods we do accept
   },
} );

//we re listing to an event  with this id "connection"
io.on("connection", (socket) => {
  console.log(`User connected: ${socket.id}`); //callback function we ca know which user is connecet
  
  socket.on("join_room", (data) => {
    socket.join(data);
    console.log(`User with ID: ${socket.id} joined room: ${data}`);
  });

  socket.on("send_message", (data) => {
    socket.to(data.room).emit("receive_message", data);
  });
  
  socket.on("disconnect", () => {
    console.log("User disconnected", socket.id);
     
  });
})


app.use(express.json());
app.use("/client", clientRoutes);
app.use("/user", userRoutes);
app.use("/auth", authRoutes);
app.use("/messagerie", messagerieRoutes);
app.use("/message", messageRoutes);

//create ma first ending requestpoint to test our app in postman
app.use('/test' ,(req , res) => {
  res.send("welcom kaliMeh");
//  res.send(User.username);

})

const port = process.env.PORT || 3001;
server.listen(port, () => {
    console.log("listening on port ",port);
})