import apiCall from './api.js';

function replyThreadCall(args, callback) {
	return apiCall("reply", {
		"id": args[0],
		"message": args[1]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return replyThreadCall(args, callback);
};