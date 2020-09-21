import apiCall from './api.js';

function leaveGroupCall(args, callback) {
	return 	apiCall("leave", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return 	leaveGroupCall(args, callback);
};