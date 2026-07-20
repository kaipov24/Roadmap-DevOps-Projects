const express = require("express");
const mongoose = require("mongoose");
require("dotenv").config();

const Todo = require("./models/todo");

const app = express();
const port = Number(process.env.PORT) || 3000;
const mongoUri = process.env.MONGODB_URI || "mongodb://127.0.0.1:27017/todo_api";

app.use(express.json());

function todoResponse(todo) {
  return {
    id: todo._id.toString(),
    title: todo.title,
    completed: todo.completed,
    createdAt: todo.createdAt,
    updatedAt: todo.updatedAt,
  };
}

function isValidObjectId(id) {
  return mongoose.Types.ObjectId.isValid(id);
}

app.get("/todos", async (req, res, next) => {
  try {
    const todos = await Todo.find().sort({ createdAt: -1 });
    res.json(todos.map(todoResponse));
  } catch (error) {
    next(error);
  }
});

app.post("/todos", async (req, res, next) => {
  try {
    const todo = await Todo.create({
      title: req.body.title,
      completed: req.body.completed,
    });

    res.status(201).json(todoResponse(todo));
  } catch (error) {
    next(error);
  }
});

app.get("/todos/:id", async (req, res, next) => {
  try {
    if (!isValidObjectId(req.params.id)) {
      return res.status(404).json({ error: "Todo not found" });
    }

    const todo = await Todo.findById(req.params.id);

    if (!todo) {
      return res.status(404).json({ error: "Todo not found" });
    }

    res.json(todoResponse(todo));
  } catch (error) {
    next(error);
  }
});

app.put("/todos/:id", async (req, res, next) => {
  try {
    if (!isValidObjectId(req.params.id)) {
      return res.status(404).json({ error: "Todo not found" });
    }

    const updates = {};

    if (Object.prototype.hasOwnProperty.call(req.body, "title")) {
      updates.title = req.body.title;
    }

    if (Object.prototype.hasOwnProperty.call(req.body, "completed")) {
      updates.completed = req.body.completed;
    }

    const todo = await Todo.findByIdAndUpdate(req.params.id, updates, {
      new: true,
      runValidators: true,
    });

    if (!todo) {
      return res.status(404).json({ error: "Todo not found" });
    }

    res.json(todoResponse(todo));
  } catch (error) {
    next(error);
  }
});

app.delete("/todos/:id", async (req, res, next) => {
  try {
    if (!isValidObjectId(req.params.id)) {
      return res.status(404).json({ error: "Todo not found" });
    }

    const todo = await Todo.findByIdAndDelete(req.params.id);

    if (!todo) {
      return res.status(404).json({ error: "Todo not found" });
    }

    res.status(204).send();
  } catch (error) {
    next(error);
  }
});

app.use((req, res) => {
  res.status(404).json({ error: "Route not found" });
});

app.use((error, req, res, next) => {
  if (error.name === "ValidationError" || error.name === "CastError") {
    return res.status(400).json({ error: error.message });
  }

  console.error(error);
  res.status(500).json({ error: "Internal server error" });
});

async function start() {
  try {
    await mongoose.connect(mongoUri);
    app.listen(port, () => {
      console.log(`Todo API listening on http://localhost:${port}`);
      console.log(`Connected to MongoDB at ${mongoUri}`);
    });
  } catch (error) {
    console.error("Failed to start server:", error);
    process.exit(1);
  }
}

start();
