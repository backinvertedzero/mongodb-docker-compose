#!/bin/bash
set -e

echo "Starting MongoDB initialization..."

echo "Waiting for MongoDB to be ready..."
counter=0
max_attempts=30

until mongosh \
  --host "$MONGO_HOST" \
  --port $MONGO_PORT \
  --username "$MONGO_INITDB_ROOT_USERNAME" \
  --password "$MONGO_INITDB_ROOT_PASSWORD" \
  --authenticationDatabase admin \
  --eval 'db.adminCommand({ ping: 1 })' > /dev/null 2>&1
do
  counter=$((counter + 1))
  if [ $counter -ge $max_attempts ]; then
    echo "MongoDB failed to become ready after $max_attempts attempts" >&2
    exit 1
  fi
  echo "Waiting for MongoDB... (attempt $counter/$max_attempts)"
  sleep 2
done

echo "MongoDB is ready!"

echo "Running initialization script..."
mongosh \
  --host "$MONGO_HOST" \
  --port $MONGO_PORT \
  --username "$MONGO_INITDB_ROOT_USERNAME" \
  --password "$MONGO_INITDB_ROOT_PASSWORD" \
  --authenticationDatabase "$MONGO_INITDB_DATABASE" \
  /init-scripts/01-create-app-db.js

echo "MongoDB initialization completed!"
echo ""
echo "Connection strings:"
echo "- App: mongodb://$MONGO_APP_USER:$MONGO_APP_PASSWORD@$MONGO_HOST:$MONGO_PORT/$MONGO_APP_DATABASE"