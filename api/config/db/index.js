import mongoose from "mongoose";

const URL =
  "mongodb+srv://quythks2011:kute9999@cluster0.k7buhmc.mongodb.net/todoApp_dev?retryWrites=true&w=majority";

export async function connect() {
  try {
    await mongoose.connect(URL);
    console.log("Connect to database");
  } catch (err) {
    console.log(err);
  }
}
