var fs         = require('fs');
var express    = require('express');
var app        = express();
var http       = require('http');
var join       = require('path').join;
var bodyParser = require('body-parser');

app.use(bodyParser.json());

var PORT = Number(process.env.PORT || 2999);

app.use(express.static(join(__dirname, '/public')));

app.get('/', function(request, response, next) {
  var indexPage;
  indexPage = join(__dirname, '/public/index.html');
  return response.status(200).sendFile(indexPage);
});

httpServer = http.createServer(app);

httpServer.listen(PORT, function() {
  return console.log('SERVER RUNNING ON ' + PORT);
});