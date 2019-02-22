FROM zenika/alpine-chrome:with-node

COPY . /usr/src/app/
WORKDIR /usr/src/app
RUN chown -R chrome:chrome /usr/src/app
RUN npm install --registry=https://registry.npm.taobao.org
EXPOSE 4000/tcp
CMD nohup sh -c 'node prerender.js && node express.js'