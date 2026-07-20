# Todo API

Simple unauthenticated Node.js API for a todo list using Express, Mongoose, and MongoDB.

## Setup

```sh
npm install
cp .env.example .env
docker compose up -d
npm run dev
```

By default, the API connects to:

```text
mongodb://127.0.0.1:27017/todo_api
```

Set `MONGODB_URI` to use a different MongoDB instance.

If you see `connect ECONNREFUSED 127.0.0.1:27017`, MongoDB is not running on your machine. Start the included MongoDB container first:

```sh
docker compose up -d
```

Then run:

```sh
npm run dev
```

## Endpoints

### Get all todos

```sh
curl http://localhost:3000/todos
```

### Create a todo

```sh
curl -X POST http://localhost:3000/todos \
  -H "Content-Type: application/json" \
  -d '{"title":"Learn Docker","completed":false}'
```

### Get one todo

```sh
curl http://localhost:3000/todos/<id>
```

### Update a todo

```sh
curl -X PUT http://localhost:3000/todos/<id> \
  -H "Content-Type: application/json" \
  -d '{"completed":true}'
```

### Delete a todo

```sh
curl -X DELETE http://localhost:3000/todos/<id>
```
