/* global process */

// Load the http module to create an http server.
var http = require('http');
var server = http.createServer(function (request, response) {
  response.writeHead(200, {"Content-Type": "text/plain"});
  response.end("Welcome to " + process.env.SX_SUMMARY + "\n");
});
server.listen(8080);
console.log("Server is running " + process.env.SX_ID + ":" + process.env.SX_VERSION);