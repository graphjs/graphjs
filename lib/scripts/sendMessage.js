import apiCall from './api.js';

function sendMessageCall(args, callback) {
	apiCall("sendMessage", {
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
	sendMessageCall(args, callback);
};