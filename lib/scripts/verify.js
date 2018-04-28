import apiCall from './api.js';

function resetCall(args, callback) {
	apiCall("verifyReset", {
		"email": args[0],
		"code": args[1]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	resetCall(args, callback);
};