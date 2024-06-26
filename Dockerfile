FROM node:20.12
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
RUN npm install pm2 -g --unsafe-perm
COPY package.json ./
COPY --chown=node:node package-lock.json ./
USER node
RUN npm i
COPY --chown=node:node . .
RUN ["chmod", "+x", "install-storefront.sh"]
RUN ["./install-storefront.sh", "v0.1.27"]
RUN ["npm", "run", "compile"]
EXPOSE 3000
CMD [ "pm2-runtime", "process.json" ]
