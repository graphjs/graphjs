import apiCall from './api.js';

function publishBlogPostCall(args, callback) {
	apiCall("publishBlogPost", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	publishBlogPostCall(args, callback);
};