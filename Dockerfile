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
  
USER node
RUN npm install

EXPOSE 5001/tcp
USER node
WORKDIR /home/node/docs

CMD ["sh", "-l", "-c", "npm run serve"]
