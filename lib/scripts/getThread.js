import apiCall from './api.js';

function getThreadCall(args, callback) {
	return apiCall("getThread", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return getThreadCall(args, callback);
};