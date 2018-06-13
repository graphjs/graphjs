import apiCall from './api.js';

function sendAnonymousMessageCall(args, callback) {
	apiCall("sendAnonymousMessage", {
		"sender": args[0],
		"to": args[1],
		"message": args[2]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	sendAnonymousMessageCall(args, callback);
};