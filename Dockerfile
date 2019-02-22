FROM zenika/alpine-chrome:with-node
USER root
COPY . /app
WORKDIR /app
RUN npm install --registry=https://registry.npm.taobao.org
EXPOSE 4000/tcp
CMD nohup sh -c 'node prerender.js && node express.js'

FROM zenika/alpine-chrome:with-node

COPY . /usr/src/app/
WORKDIR /usr/src/app
RUN sudo chown -R chrome:chrome /usr/src/app
RUN npm install --registry=https://registry.npm.taobao.org
EXPOSE 4000/tcp
CMD nohup sh -c 'node prerender.js && node express.js'