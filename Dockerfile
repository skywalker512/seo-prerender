FROM node:11.4.0-alpine

COPY . /app
WORKDIR /app
RUN npm install --registry=https://registry.npm.taobao.org
EXPOSE 4000/tcp
CMD nohup sh -c 'node prerender.js && node express.js'