import apiCall from './api.js';

function addCommentCall(args, callback) {
	return apiCall("addComment", {
		"url": args[0],
		"content": args[1]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return addCommentCall(args, callback);
};