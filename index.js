var express = require('express');
var app = express();
var path = require('path');

// viewed at http://localhost:8080
app.use(express.static(path.join(__dirname, 'lib/')));
app.use(express.static(path.join(__dirname, 'demo/')));
app.get('/', function(req, res) {
    res.sendFile(path.join(__dirname + '/demo/index.html'));
});

app.listen(8080);
console.log('demo is hosted:  http://localhost:8080');

// var phonetworks = require('pho-js-client');
// const baseURL = 'http://phonetworks.com:1338/'
// var api = new phonetworks.DefaultApi(baseURL);
// // var api = new phonetworks.ApiClient();
// // api.setBaseUrl(baseURL);
// console.log(api);
// var callback = function(error, data, response) {
// 	console.log("---------- data -----------\n", error, data);
// };
// api.getFounder(callback);