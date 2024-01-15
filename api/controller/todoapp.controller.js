import express from "express";
import Todo from "../models/todoapp.model.js";
const app = express();

export const getTodoList = async (req, res) => {
  try {
    const SKIP_ITEMS = 10;
    if (req.query.page) {
      let skip = (parseInt(req.query.page) - 1) * SKIP_ITEMS;
      const todo = await Todo.find({})
        .limit(SKIP_ITEMS)
        .skip(skip)
        .sort("createdAt");
      res.status(200).json(todo);
    } else {
      const todo = await Todo.find({});
      res.status(200).json(todo);
    }
  } catch (err) {
    res.status(500).json(err);
  }
};
export const getTodoListById = async (req, res) => {
  try {
    const todo = await Todo.findById(req.params.id);
    res.status(200).json(todo);
  } catch (err) {
    res.status(500).json(err);
  }
};
export const postTodoList = async (req, res) => {
  try {
    const todo = await Todo.create(req.body);
    res.status(201).json(todo);
  } catch (err) {
    res.status(500).json(err);
  }
};
export const updateTodoList = async (req, res) => {
  try {
    if (Todo.findById(req.params.id)) {
      const todo = await Todo.findByIdAndUpdate(req.params.id, req.body, {
        new: true,
      });
      res.status(200).json(todo);
    } else res.status(404).json("Todo not found");
  } catch (error) {
    res.status(500).json(error);
  }
};
export const deleteTodoList = async (req, res) => {
  try {
    if (Todo.findById(req.params.id)) {
      await Todo.findByIdAndDelete(req.params.id);
      res.status(200).json("Todo deleted");
    } else res.status(404).json("Todo not found");
  } catch (error) {
    res.status(500).json(error);
  }
};
