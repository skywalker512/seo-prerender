FROM zenika/alpine-chrome:with-node
COPY . /app
WORKDIR /app
RUN npm install --registry=https://registry.npm.taobao.org
EXPOSE 4000/tcp
CMD nohup sh -c 'node prerender.js && node express.js'