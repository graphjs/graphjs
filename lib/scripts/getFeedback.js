import apiCall from './api.js';

function getFeedbackCall(args, callback) {
	return 	apiCall("getFeedback", {
		"url": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return getFeedbackCall(args, callback);
};