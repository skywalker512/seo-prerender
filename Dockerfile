FROM zenika/alpine-chrome:with-node

COPY --chown=chrome . /usr/src/app/
RUN npm install --registry=https://registry.npm.taobao.org
COPY --chown=chrome . /usr/src/app
WORKDIR /usr/src/app
EXPOSE 4000/tcp
CMD nohup sh -c 'node prerender.js && node express.js'