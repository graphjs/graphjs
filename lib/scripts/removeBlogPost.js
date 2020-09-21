import apiCall from './api.js';

function removeBlogPostCall(args, callback) {
	return apiCall("removeBlogPost", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return removeBlogPostCall(args, callback);
};