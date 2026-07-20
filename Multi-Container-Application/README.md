# Todo API

Simple unauthenticated Node.js API for a todo list using Express, Mongoose, and MongoDB.

## Setup

Run both the API and MongoDB with Docker Compose:

```sh
docker compose up --build
```

The API will be available at:

```text
http://localhost:3001
```

Docker Compose runs two services:

- `api` - Node.js Express API
- `mongodb` - MongoDB database with persistent storage

Inside Docker, the API connects to MongoDB with:

```text
mongodb://mongodb:27017/todo_api
```

The API container still listens on port `3000` internally. Compose publishes it to host port `3001` by default to avoid conflicts with other local apps. Change `API_PORT` in `.env` if you want a different host port.

For local development without dockerizing the API, install dependencies and run nodemon:

```sh
npm install
cp .env.example .env
docker compose up -d mongodb
npm run dev
```

In local development, `.env` uses:

```text
mongodb://127.0.0.1:27017/todo_api
```

Set `MONGODB_URI` to use a different MongoDB instance.

## Endpoints

### Get all todos

```sh
curl http://localhost:3001/todos
```

### Create a todo

```sh
curl -X POST http://localhost:3001/todos \
  -H "Content-Type: application/json" \
  -d '{"title":"Learn Docker","completed":false}'
```

### Get one todo

```sh
curl http://localhost:3001/todos/<id>
```

### Update a todo

```sh
curl -X PUT http://localhost:3001/todos/<id> \
  -H "Content-Type: application/json" \
  -d '{"completed":true}'
```

### Delete a todo

```sh
curl -X DELETE http://localhost:3001/todos/<id>
```
