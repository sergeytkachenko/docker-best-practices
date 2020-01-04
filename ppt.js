const static = require('node-static');
const file = new static.Server('.');

require('http').createServer(function (request, response) {
    request.addListener('end', function () {
        file.serve(request, response);
    }).resume();
}).listen(8080);
console.log('server listening on 8080 port');

process.on('SIGINT', function() {
    process.exit();
});
