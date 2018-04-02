import apiCall from './api.js';

function getGroupCall(args, callback) {
	apiCall("getGroup", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	getGroupCall(args, callback);
};