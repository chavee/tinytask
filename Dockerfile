# Stage 1: Build stage
# Use a Node.js 20 base image for building the application
FROM node:20-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies using npm ci for reproducible builds
RUN npm ci

# Copy the rest of the application source code
COPY . .

# Build the TypeScript application
RUN npm run build

# Prune development dependencies to reduce the size of the final image
RUN npm prune --production

# Stage 2: Production stage
# Use a slim Node.js 20 image for the final container
FROM node:20-alpine

# Set the working directory
WORKDIR /app

# Copy only the necessary files from the builder stage
# - node_modules with production dependencies
# - dist folder with the compiled JavaScript code
# - public folder with static assets
# - package.json to run the start script
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./

# Expose port 3000
EXPOSE 3000

# The command to run the application
CMD [ "npm", "start" ]
