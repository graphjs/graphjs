import apiCall from './api.js';

function getIdCall(args, callback) {
	return apiCall("getId", {
		"ref": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return 	getIdCall(args, callback);
};