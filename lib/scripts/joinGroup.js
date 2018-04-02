import apiCall from './api.js';

function joinGroupCall(args, callback) {
	apiCall("join", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	joinGroupCall(args, callback);
};