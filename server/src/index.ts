import express, { Request, Response } from 'express';
import mongoose from 'mongoose';
import bodyParser from "body-parser"
import cors from 'cors';
import cookieParser from 'cookie-parser';
import dotenv from "dotenv"
import { app, server } from './socket/socket.server';

dotenv.config()


import entryRoutes from "./routes/authentication.routes";
import chatRoutes from "./routes/chat.routes";


const port = 3000;

const MONGODB_CONNECTION: any = process.env.MONGODB_CONNECTION;
mongoose
    .connect(MONGODB_CONNECTION)
    .then(() => {
        console.log('connected to MongoDB');
    })
    .catch((error) => {
        console.log('Internal Server Error');
    });

app.use(
    cors({
        origin: process.env.CLIENT_URL,
        credentials: true,
    })
);

app.use(express.json())
app.use(
    bodyParser.urlencoded({
        extended: true,
    }),
);
app.use(cookieParser())

app.use("/authentication", entryRoutes)
app.use("/chat", chatRoutes)


app.get('/', (req: Request, res: Response) => {
    res.send('Hello from your Node.js Express server!');
});

server.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});