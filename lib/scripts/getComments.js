import apiCall from './api.js';

function getCommentsCall(args, callback) {
	return apiCall("getComments", {
		"url": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return getCommentsCall(args, callback);
};