import apiCall from './api.js';

function getProfileCall(args, callback) {
	apiCall("getProfile", {
		"id": args[0]
	},
	function (response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	var callback = args.pop();
	getProfileCall(args, callback);
};