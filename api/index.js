import express from "express";
import router from "./routes/todoapp.route.js";
import { connect } from "./config/db/index.js";
const app = express();
const port = 3000;

app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});

app.use(express.json());
app.use("/", router);

connect();
