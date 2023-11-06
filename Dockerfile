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
FROM node:lts as base

# We'll run the app as the `node` user, so put it in their home directory
WORKDIR /home/node/app
# Copy the source code over
COPY --chown=node:node . /home/node/app/

## Development #################################################################
# Define a development target that installs devDeps and runs in dev mode
FROM base as development
WORKDIR /home/node/app
# Install (not ci) with dependencies, and for Linux vs. Linux Musl (which we use for -alpine)
RUN npm install
# Switch to the node user vs. root
USER node
# Expose port 5000
EXPOSE 5000
# Start the app in debug mode so we can attach the debugger
CMD ["npm", "serve"]
