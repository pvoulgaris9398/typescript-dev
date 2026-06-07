# --- Stage 1: Build the TypeScript code ---
FROM node:20-alpine AS builder
WORKDIR /app

# Copy configuration files
COPY package*.json tsconfig.json ./

# Install all dependencies (including devDependencies for typescript compiler)
RUN npm ci

# Copy source code and build the project
COPY src ./src
RUN npm run build

# --- Stage 2: Run the production application ---
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production

# Copy package configurations
COPY package*.json ./

# Install only production-level dependencies to minimize image size
RUN npm ci --only=production

# Copy compiled JavaScript from the builder stage
COPY --from=builder /app/dist ./dist

EXPOSE 3000

CMD ["npm", "run", "start:prod"]
