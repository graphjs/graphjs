import apiCall from './api.js';

function removeBlogCommentCall(args, callback) {
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
	removeBlogCommentCall(args, callback);
};