#!/bin/bash

set -euo pipefail

CONTAINER="todo-api-mongodb"
BUCKET="mongo-backups"
ENDPOINT="https://YOUR_ACCOUNT_ID.r2.cloudflarestorage.com"
TIMESTAMP=$(date -u +"%Y-%m-%d_%H-%M-%S")
CONTAINER_BACKUP="/tmp/mongo-backup-${TIMESTAMP}"
HOST_BACKUP="/tmp/mongo-backup-${TIMESTAMP}"
ARCHIVE="/tmp/mongo-backup-${TIMESTAMP}.tar.gz"

cleanup() {
    docker exec "$CONTAINER" rm -rf "$CONTAINER_BACKUP" 2>/dev/null || true
    rm -rf "$HOST_BACKUP"
    rm -f "$ARCHIVE"
}

trap cleanup EXIT

docker exec "$CONTAINER" mongodump --out "$CONTAINER_BACKUP"

docker cp "${CONTAINER}:${CONTAINER_BACKUP}" "$HOST_BACKUP"

tar -czf "$ARCHIVE" -C /tmp "mongo-backup-${TIMESTAMP}"

aws s3 cp "$ARCHIVE" \
    "s3://${BUCKET}/mongo-backup-${TIMESTAMP}.tar.gz" \
    --endpoint-url "$ENDPOINT" \
    --profile r2

echo "Backup uploaded successfully: mongo-backup-${TIMESTAMP}.tar.gz"