import apiCall from './api.js';

function loginCall(args, callback) {
	apiCall("generateFeedToken", {
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
	loginCall(args, callback);
};