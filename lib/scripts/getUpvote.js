import apiCall from './api.js';

function getUpvoteCall(args, callback) {
	apiCall("isStarred", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	getUpvoteCall(args, callback);
};