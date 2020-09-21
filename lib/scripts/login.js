import apiCall from './api.js';
import handleLoginCookies from './_handleLoginCookies.js';
const Q = require("q");

function loginCall(args, callback) {
	var def = Q.defer();
	let username = args[0];
	window.GraphJS.events.emit("beforeLogin");
	let _call = apiCall("login", {
		"username": username,
		"password": args[1]
	},
	function(response) {
		callback(response.data);
	}, false);
	_call.then(res => 
	{
		if(res.success) {
			handleLoginCookies(username, res.id);
			window.GraphJS.events.emit("afterLogin", args, res);
		}
		def.resolve(res);
	});
	_call.catch(err =>
	{
		def.reject(err);
	});
	return def.promise;
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return loginCall(args, callback);
};
