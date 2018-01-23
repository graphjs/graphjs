var phonetworks = require('pho-js-client');
const baseURL = 'http://phonetworks.com:1338/'
var api = new phonetworks.DefaultApi(baseURL);
// var api = new phonetworks.ApiClient();
// api.setBaseUrl(baseURL);
console.log(api);
var callback = function(error, data, response) {
	console.log("---------- data -----------\n", error, data);
};
api.getFounder(callback);