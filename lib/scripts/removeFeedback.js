import apiCall from './api.js';

function removeFeedbackCall(args, callback) {
	return 	apiCall("removeFeedback", {
		"feedback_id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return removeFeedbackCall(args, callback);
};