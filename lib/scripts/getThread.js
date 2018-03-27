import apiCall from './api.js';

function getThreadCall(args, callback) {
	apiCall("getThread", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	var callback = args.pop();
	getThreadCall(args, callback);
};