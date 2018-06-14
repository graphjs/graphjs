import apiCall from './api.js';

function addFeedbackCall(args, callback) {
	apiCall("addFeedback", {
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
	addFeedbackCall(args, callback);
};