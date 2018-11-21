import apiCall from './api.js';

function removeBlogPostCall(args, callback) {
	apiCall("removeBlogPost", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	removeBlogPostCall(args, callback);
};