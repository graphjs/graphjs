import apiCall from './api.js';

function leaveGroupCall(args, callback) {
	apiCall("leave", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	leaveGroupCall(args, callback);
};