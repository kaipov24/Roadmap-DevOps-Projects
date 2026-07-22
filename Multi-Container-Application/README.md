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

### Health check

```sh
curl http://localhost:3001/health
```

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

## CI/CD deployment

The GitHub Actions workflow at `.github/workflows/deploy-api-image.yml` deploys the app whenever changes are pushed to `main`.

The pipeline:

- Builds the Node.js API Docker image.
- Pushes the image to GitHub Container Registry.
- Connects to the remote server over SSH.
- Pulls the newest Docker image.
- Runs `docker compose up -d`.

Add these GitHub repository secrets:

- `AWS_HOST` - remote server IP address or hostname.
- `AWS_USER` - SSH user for the remote server.
- `AWS_SSH_KEY` - private SSH key for the remote server.
- `AWS_SSH_PORT` - optional SSH port, defaults to `22`.
- `DEPLOY_PATH` - optional remote directory, defaults to `/opt/todo-api`.
- `API_PORT` - optional public API port, defaults to `3001`.

The production server is prepared by the Ansible playbook in `ansible/setup.yml`. The app role writes `/opt/todo-api/docker-compose.yml` from `roles/app/templates/docker-compose.prod.yml.j2`, using the GHCR API image, MongoDB, and the persistent `mongodb_data` volume. Re-run Ansible if the production Compose template changes.
