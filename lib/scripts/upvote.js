import apiCall from './api.js';

function upvoteCall(args, callback) {
	return apiCall("star", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return upvoteCall(args, callback);
};