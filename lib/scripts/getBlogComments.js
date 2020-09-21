import apiCall from './api.js';

function getBlogCommentsCall(args, callback) {
	return apiCall("getComments", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return getBlogCommentsCall(args, callback);
};