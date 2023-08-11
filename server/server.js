const express = require('express');
const bodyParser = require('body-parser');
const { setup, setupSequelize, defineModels } = require('./sequelize');

async function main() {
  const sequelize = setupSequelize();
  const { Todo } = defineModels(sequelize);

  const app = express();
  app.use(bodyParser.json());

  app.use('/api/GetTodoList', async (req, res) => {
    const todoList = await Todo.findAll({
      order: [['id', 'DESC']],
    });
    res.send({ todoList });
  });

  app.use('/api/AddTodo', async (req, res) => {
    const {
      APIPayload: { content },
    } = req.body;
    console.log('AddTodo', req.body, content);
    const todo = await Todo.create({ content });
    res.send({ id: todo.id });
  });

  app.use('/api/RemoveTodo', async (req, res) => {
    const {
      APIPayload: { id },
    } = req.body;
    await Todo.destroy({ where: { id } });
    res.send({ id });
  });

  app.listen(8000);
}

if (process.env.SETUP) {
  setup();
} else {
  main();
}