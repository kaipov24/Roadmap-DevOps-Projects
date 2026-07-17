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
