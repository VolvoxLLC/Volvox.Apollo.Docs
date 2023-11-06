FROM node:lts-alpine

LABEL name="Docusaurus on docker latest-stable" \
      maintainer="VolvoxLLC <support@volvox.tech>" \
      version="1.0.0" \
      release="latest" \
      url="https://github.com/VolvoxLLC/Volvox.Apollo.Docs" \
      summary="Docusaurus v3 for Docker \
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
RUN mkdir ~/npm-global \
    && npm config set prefix '~/npm-global' \
    && echo 'export PATH=~/npm-global/bin:$PATH' > ~/.profile \
    && mkdir -p /home/node/docs \
    && cd /home/node/docs \
    && npm install --global docusaurus-init \
    && sh -l -c docusaurus-init \ 
    && rm Dockerfile \
    && rm docker-compose.yml

EXPOSE 5001/tcp
USER node
WORKDIR /home/node/docs

CMD ["sh", "-l", "-c", "npm start"]
HEALTHCHECK CMD curl -f -L http://localhost:5001/ || exit 1
