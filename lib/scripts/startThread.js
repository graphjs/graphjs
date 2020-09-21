import apiCall from './api.js';

function startThreadCall(args, callback) {
	return apiCall("startThread", {
		"title": args[0],
		"message": args[1]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return startThreadCall(args, callback);
};