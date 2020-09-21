import apiCall from './api.js';

function addPrivateContentCall(args, callback) {
	return apiCall("addPrivateContent", {
		"data": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return addPrivateContentCall(args, callback);
};