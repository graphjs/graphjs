import apiCall from './api.js';

function publishBlogPostCall(args, callback) {
	return 	apiCall("publishBlogPost", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return publishBlogPostCall(args, callback);
};