import apiCall from './api.js';

function unpublishBlogPostCall(args, callback) {
	apiCall("unpublishBlogPost", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	unpublishBlogPostCall(args, callback);
};