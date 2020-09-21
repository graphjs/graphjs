import apiCall from './api.js';

function getMessageCall(args, callback) {
	return 	apiCall("getMessage", {
		"msgid": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return 	getMessageCall(args, callback);
};