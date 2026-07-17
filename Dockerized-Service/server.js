const crypto = require("node:crypto");
const fs = require("node:fs");
const http = require("node:http");
const path = require("node:path");

function loadEnv(filePath) {
  if (!fs.existsSync(filePath)) {
    return;
  }

  const contents = fs.readFileSync(filePath, "utf8");

  for (const line of contents.split(/\r?\n/)) {
    const trimmed = line.trim();

    if (!trimmed || trimmed.startsWith("#")) {
      continue;
    }

    const separatorIndex = trimmed.indexOf("=");
    if (separatorIndex === -1) {
      continue;
    }

    const key = trimmed.slice(0, separatorIndex).trim();
    let value = trimmed.slice(separatorIndex + 1).trim();

    if (
      (value.startsWith('"') && value.endsWith('"')) ||
      (value.startsWith("'") && value.endsWith("'"))
    ) {
      value = value.slice(1, -1);
    }

    if (key && process.env[key] === undefined) {
      process.env[key] = value;
    }
  }
}

function safeCompare(actual, expected) {
  const actualBuffer = Buffer.from(actual);
  const expectedBuffer = Buffer.from(expected);

  return (
    actualBuffer.length === expectedBuffer.length &&
    crypto.timingSafeEqual(actualBuffer, expectedBuffer)
  );
}

function parseBasicAuth(header) {
  if (!header || !header.startsWith("Basic ")) {
    return null;
  }

  const credentials = Buffer.from(header.slice("Basic ".length), "base64").toString("utf8");
  const separatorIndex = credentials.indexOf(":");

  if (separatorIndex === -1) {
    return null;
  }

  return {
    username: credentials.slice(0, separatorIndex),
    password: credentials.slice(separatorIndex + 1),
  };
}

function sendText(res, statusCode, body, headers = {}) {
  res.writeHead(statusCode, {
    "Content-Type": "text/plain; charset=utf-8",
    ...headers,
  });
  res.end(body);
}

loadEnv(path.join(__dirname, ".env"));

const secretMessage = process.env.SECRET_MESSAGE || "";
const username = process.env.USERNAME || "";
const password = process.env.PASSWORD || "";
const port = Number(process.env.PORT) || 3000;

const server = http.createServer((req, res) => {
  const url = new URL(req.url, `http://${req.headers.host}`);

  if (req.method !== "GET") {
    sendText(res, 405, "Method Not Allowed\n", { Allow: "GET" });
    return;
  }

  if (url.pathname === "/") {
    sendText(res, 200, "Hello, world!\n");
    return;
  }

  if (url.pathname === "/secret") {
    const credentials = parseBasicAuth(req.headers.authorization);
    const isAuthenticated =
      credentials &&
      safeCompare(credentials.username, username) &&
      safeCompare(credentials.password, password);

    if (!isAuthenticated) {
      sendText(res, 401, "Invalid username or password.\n", {
        "WWW-Authenticate": 'Basic realm="Secret Area"',
      });
      return;
    }

    sendText(res, 200, `${secretMessage}\n`);
    return;
  }

  sendText(res, 404, "Not Found\n");
});

server.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
