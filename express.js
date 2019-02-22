const express = require('express')
const app = express()
const redis = require("redis"),
client = redis.createClient({ url: process.env.REDIS  }),
cacheableStatusCodes = { 200: true, 302: true, 404: true }

app.use(require('prerender-node')
    .set('protocol', process.env.HOST_PROTOCOL)
    .set('host', process.env.HOST_URL)
    .set('prerenderServiceUrl', 'http://127.0.0.1:3000')
    .set('forwardHeaders', true)
    .set('beforeRender', function (req, done) {
        client.hmget(req.url, 'body', 'status', function (err, fields) {
            if (err) return done(err);
            done(err, { body: fields[0], status: fields[1] });
        });
    })
    .set('afterRender', function (err, req, prerender_res) {
        if (cacheableStatusCodes[prerender_res.statusCode]) {
            client.hmset(req.url, 'body', prerender_res.body, 'status', prerender_res.statusCode);
        }
    })
)


app.get('/', function (req, res) {
    res.send('if you are not a robot please contact administrator');
})

app.listen(4000);