import apiCall from './api.js';

function getGroupCall(args, callback) {
	return apiCall("getGroup", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return getGroupCall(args, callback);
};