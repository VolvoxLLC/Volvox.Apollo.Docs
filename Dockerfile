# Use a larger node image to do the build for native deps (e.g., gcc, python)
FROM node:lts-alpine AS deps

WORKDIR /opt/app
# Copy package.json and package-lock.json to the working directory
COPY package.json package-lock.json ./
COPY . /
# Install production dependencies only
RUN npm ci --only=production
# Build the application
RUN npm run build

# Stage 2: Build the application
FROM node:lts-alpine AS builder

WORKDIR /opt/app
# Copy all files from the current directory to the working directory in the container
# Copy node_modules from the "deps" stage
COPY package.json package-lock.json ./
COPY --from=deps /opt/app/node_modules ./node_modules

# Stage 3: Create the production image
FROM node:lts-alpine AS runner
# Set the working directory in the container to /opt/app
WORKDIR /opt/app
# Set environment variable
ENV NODE_ENV=production
# Copy necessary files from the "builder" stage
EXPOSE 5000
COPY --from=builder /opt/app/build ./build
COPY package.json package-lock.json ./
# Define the command to run the application
CMD run.sh