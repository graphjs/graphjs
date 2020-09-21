import apiCall from './api.js';

function commentBlogPostCall(args, callback) {
	return apiCall("addComment", {
		"id": args[0],
		"content": args[1]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return commentBlogPostCall(args, callback);
};