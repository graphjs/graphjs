import apiCall from './api.js';

function sendMessageCall(args, callback) {
	return apiCall("sendMessage", {
		"to": args[0],
		"message": args[1]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return 	sendMessageCall(args, callback);
};