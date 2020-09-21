import apiCall from './api.js';

function editCommentCall(args, callback) {
	return apiCall("editComment", {
		"id": args[0],
		"content": args[1]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return editCommentCall(args, callback);
};