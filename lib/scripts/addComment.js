import apiCall from './api.js';

function addCommentCall(args, callback) {
	apiCall("addComment", {
		"url": args[0],
		"content": args[1]
	},
	function (response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	var callback = args.pop();
	addCommentCall(args, callback);
};