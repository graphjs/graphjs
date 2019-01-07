import apiCall from './api.js';

function removeStatusUpdateCommentCall(args, callback) {
	apiCall("removeComment", {
		"comment_id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	removeStatusUpdateCommentCall(args, callback);
};