# ------------ BUILD STAGE ------------
FROM node:18 AS builder

WORKDIR /app

# Copy package files first (layer caching)
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy application code
COPY . .

# ------------ RUNTIME STAGE ------------
FROM node:18-slim AS runtime

WORKDIR /app

# Copy only necessary files
COPY --from=builder /app /app

# Expose port
EXPOSE 3000

# Run server
CMD ["node", "src/app.js"]
