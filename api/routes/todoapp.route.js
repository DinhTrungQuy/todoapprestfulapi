import express from "express";
import {
  deleteTodoList,
  getTodoList,
  getTodoListById,
  postTodoList,
  updateTodoList,
} from "../controller/todoapp.controller.js";

const router = express.Router();

router.get("/api/v1/todos", getTodoList);
router.get("/api/v1/todo/:id", getTodoListById);
router.post("/api/v1/todos", postTodoList);
router.put("/api/v1/todos/:id", updateTodoList);
router.delete("/api/v1/todos/:id", deleteTodoList);

export default router;
