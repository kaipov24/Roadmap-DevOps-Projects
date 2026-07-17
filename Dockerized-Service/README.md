# Dockerized Service

Simple Node.js service with:

- `GET /` returning `Hello, world!`
- `GET /secret` protected by Basic Auth and returning `SECRET_MESSAGE`

## Run

```sh
npm start
```

The service listens on port `3000` by default. You can override it with `PORT=4000 npm start`.

## Environment

The `.env` file must define:

```env
SECRET_MESSAGE=This is the secret message.
USERNAME=admin
PASSWORD=password
```

## Test

```sh
curl http://localhost:3000/
curl -i http://localhost:3000/secret
curl -u admin:password http://localhost:3000/secret
```

## Docker

```sh
docker build -t dockerized-service .
docker run --env-file .env -p 3000:3000 dockerized-service
```

## GitHub Actions Deployment

The workflow at `.github/workflows/deploy-dockerized-service.yml` builds the image, pushes it to GitHub Container Registry, then deploys it on a remote server over SSH.

Add these GitHub repository secrets:

```text
SERVER_HOST
SERVER_USER
SERVER_SSH_KEY
GHCR_USERNAME
GHCR_TOKEN
SECRET_MESSAGE
BASIC_AUTH_USERNAME
BASIC_AUTH_PASSWORD
```

`GHCR_TOKEN` should be a GitHub token with `read:packages` permission so the remote server can pull the image. The remote server must already have Docker installed and the SSH user must be allowed to run Docker.
