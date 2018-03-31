import apiCall from './api.js';

function createGroupCall(args, callback) {
	apiCall("createGroup", {
		"title": args[0],
		"description": args[1]
	},
	function(response) {
		callback(response);
	});
};

export default function() {
	let args = Array.from(arguments);
	var callback = args.pop();
	createGroupCall(args, callback);
};