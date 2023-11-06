FROM node:lts-alpine

LABEL name="Docusaurus on docker latest-stable" \
      maintainer="VolvoxLLC <support@volvox.tech>" \
      version="1.0.0" \
      release="latest" \
      url="https://github.com/VolvoxLLC/Volvox.Apollo.Docs" \
      summary="Volvox.Apollo Docs Docker \
          on Node 20.x, lts-alpine" \
      description="Volvox.Apollo Docs \
          on Node 20.x, lts-alpine" 

# add curl for healthcheck
RUN apk add --no-cache --update \
  curl \
  libc6-compat

# run as our node user from base image
# we delete the dockerfiles we don't need
# this leaves us with a default v1 docusarus install
# we can mount our own into the container
USER node
RUN npm install --global docusaurus-init

EXPOSE 5001/tcp
USER node
WORKDIR /home/node/docs

CMD ["sh", "-l", "-c", "npm run serve"]
HEALTHCHECK CMD curl -f -L http://localhost:5001/ || exit 1
