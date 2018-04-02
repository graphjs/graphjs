import apiCall from './api';

function registerCall(args, callback) {
	apiCall("signup", {
		"username": args[0],
		"email": args[1],
		"password": args[2]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	registerCall(args, callback);
};