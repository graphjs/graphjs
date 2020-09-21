import apiCall from './api.js';

function getBlogPostCall(args, callback) {
	return apiCall("getBlogPost", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return getBlogPostCall(args, callback);
};