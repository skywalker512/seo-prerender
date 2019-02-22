const prerender = require('prerender');
const server = prerender({
    workers: 1
})
server.start();