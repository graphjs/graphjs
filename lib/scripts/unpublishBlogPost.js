import apiCall from './api.js';

function unpublishBlogPostCall(args, callback) {
	return apiCall("unpublishBlogPost", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return unpublishBlogPostCall(args, callback);
};