import apiCall from './api.js';

function removeBlogCommentCall(args, callback) {
	return 	apiCall("removeComment", {
		"comment_id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return 	removeBlogCommentCall(args, callback);
};