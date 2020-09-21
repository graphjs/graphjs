import apiCall from './api.js';

function removeUpvoteCall(args, callback) {
	return apiCall("unstar", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return removeUpvoteCall(args, callback);
};