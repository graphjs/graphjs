import apiCall from './api.js';

function editReplyCall(args, callback) {
	apiCall("editForumPost", {
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
	editReplyCall(args, callback);
};