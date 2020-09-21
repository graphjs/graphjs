import apiCall from './api.js';

function resetCall(args, callback) {
	return 	apiCall("resetPassword", {
		"email": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return 	resetCall(args, callback);
};