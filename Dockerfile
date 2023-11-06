# Stage 1: Install dependencies
# Use an official Node.js runtime as a parent image
FROM node:lts-alpine AS deps
# Set the working directory in the container to /opt/app
WORKDIR /opt/app
# Copy package.json and package-lock.json to the working directory
COPY package.json package-lock.json ./
# Install production dependencies only
RUN npm ci --only=production

# Stage 2: Build the application
FROM node:lts-alpine AS builder
# Set environment variables
ENV NODE_ENV=production

WORKDIR /opt/app
# Copy all files from the current directory to the working directory in the container
COPY . .
# Copy node_modules from the "deps" stage
COPY --from=deps /opt/app/node_modules ./node_modules
# Build the application
RUN npm run build

# Stage 3: Create the production image
FROM node:lts-alpine AS runner
# Set the working directory in the container to /opt/app
WORKDIR /opt/app
# Set environment variable
ENV NODE_ENV=production
# Copy necessary files from the "builder" stage
COPY --from=builder /opt/app/public ./public
COPY --from=builder /opt/app/next.config.js ./
COPY --from=builder /opt/app/.next ./.next
COPY --from=builder /opt/app/pages ./pages
COPY --from=builder /opt/app/node_modules ./node_modules
# Define the command to run the application
CMD ["node_modules/.bin/next", "start"]
