import apiCall from './api.js';

function replyThreadCall(args, callback) {
	apiCall("replyThread", {
		"id": args[0],
		"message": args[1]
	},
	function (response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	var callback = args.pop();
	replyThreadCall(args, callback);
};