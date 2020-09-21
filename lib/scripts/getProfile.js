import apiCall from './api.js';

function getProfileCall(args, callback) {
	return apiCall("getProfile", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return getProfileCall(args, callback);
};