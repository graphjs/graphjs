import apiCall from './api.js';

function followCall(args, callback) {
	return apiCall("follow", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return followCall(args, callback);
};