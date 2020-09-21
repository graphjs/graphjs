import apiCall from './api.js';

function joinGroupCall(args, callback) {
	return apiCall("join", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return joinGroupCall(args, callback);
};