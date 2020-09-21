import apiCall from './api.js';

function loginCall(args, callback) {
	return apiCall("generateFeedToken", {
		"type": args[0],
		"id": args[1]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return loginCall(args, callback);
};