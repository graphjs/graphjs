import apiCall from './post.js'; // Moved to POST api

function startBlogPostCall(args, callback) {
	return apiCall("startBlogPost", {
		"title": args[0],
		"content": args[1]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return startBlogPostCall(args, callback);
};