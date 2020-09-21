import apiCall from './api.js';

function getUpvoteCall(args, callback) {
	return apiCall("isStarred", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return 	getUpvoteCall(args, callback);
};