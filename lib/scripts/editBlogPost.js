import apiCall from './post.js';

function editBlogPostCall(args, callback) {
	return apiCall("editBlogPost", {
		"id": args[0],
		"title": args[1],
		"content": args[2]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return editBlogPostCall(args, callback);
};