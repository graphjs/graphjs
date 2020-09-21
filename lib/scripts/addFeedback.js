import apiCall from './api.js';

function addFeedbackCall(args, callback) {
	return apiCall("addFeedback", {
		"url": args[0],
		"content": args[1],
		"rating": args[2]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return addFeedbackCall(args, callback);
};