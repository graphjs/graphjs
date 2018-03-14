import apiCall from './api.js';

function loginCall(args, callback) {
	apiCall("login", {
		"username": args[0],
		"password": args[1]
	},
	function (response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	var callback = args.pop();
	loginCall(args, callback);
};