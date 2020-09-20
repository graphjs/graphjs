import apiCall from './api.js';

function starCall(args, callback) {
	return apiCall("star", {
		"url": args[0]
	},
	function(response) {
		callback(response.data);
	},
	);
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return starCall(args, callback);
};