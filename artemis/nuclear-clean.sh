#!/bin/bash

echo "Stopping and removing all Docker containers..."
docker rm -f $(docker ps -aq) 2>/dev/null || echo "No containers found."

echo "Removing all Docker volumes..."
docker volume rm $(docker volume ls -q) 2>/dev/null || echo "No volumes found."

echo "Pruning remaining network and build caches..."
docker system prune -a --volumes -f

echo "Rebuilding and starting your Docker Compose stack..."
docker compose up --build -d

echo "Rebuild complete!"