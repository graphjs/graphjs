import apiCall from './api.js';

function getMessageCall(args, callback) {
	apiCall("getMessage", {
		"msgid": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	var callback = args.pop();
	getMessageCall(args, callback);
};