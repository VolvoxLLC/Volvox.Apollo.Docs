# FROM node:lts-alpine

# LABEL name="Docusaurus on docker latest-stable" \
#       maintainer="VolvoxLLC <support@volvox.tech>" \
#       version="1.0.0" \
#       release="latest" \
#       url="https://github.com/VolvoxLLC/Volvox.Apollo.Docs" \
#       summary="Volvox.Apollo Docs Docker \
#           on Node 20.x, lts-alpine" \
#       description="Volvox.Apollo Docs \
#           on Node 20.x, lts-alpine" 
  
# # run as our node user from base image
# # we delete the dockerfiles we don't need
# # this leaves us with a default v1 docusarus install
# # we can mount our own into the container
# USER node
# RUN mkdir ~/npm-global \
#     && npm config set prefix '~/npm-global' \
#     && echo 'export PATH=~/npm-global/bin:$PATH' > ~/.profile \
#     && mkdir -p /home/node/docs \
#     && cd /home/node/docs \
#     && npm install --global docusaurus-init \
#     && sh -l -c docusaurus-init

# EXPOSE 5001/tcp
# USER node
# WORKDIR /home/node/docs

# CMD ["sh", "-l", "-c", "npm run serve"]

## Base ########################################################################
# Use a larger node image to do the build for native deps (e.g., gcc, python)
FROM node:lts-alpine AS deps

WORKDIR /opt/app
# Copy package.json and package-lock.json to the working directory
COPY package.json package-lock.json ./
# Install production dependencies only
RUN npm ci --only=production

# Stage 2: Build the application
FROM node:lts-alpine AS builder

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
EXPOSE 5000
# Define the command to run the application
CMD ["sh", "-l", "-c", "npm run serve"]
