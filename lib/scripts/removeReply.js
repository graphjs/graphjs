import apiCall from './api.js';

function removeCommentCall(args, callback) {
	apiCall("deleteForumPost", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	removeCommentCall(args, callback);
};