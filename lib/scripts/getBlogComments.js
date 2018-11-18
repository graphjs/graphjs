import apiCall from './api.js';

function getBlogCommentsCall(args, callback) {
	apiCall("getComments", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	getBlogCommentsCall(args, callback);
};