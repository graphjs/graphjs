import apiCall from './api.js';

function removeCommentCall(args, callback) {
	return apiCall("removeComment", {
		"comment_id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return 	removeCommentCall(args, callback);
};