import apiCall from './api.js';

function followCall(args, callback) {
	apiCall("follow", {
		"id": args[0]
	},
	function (response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	var callback = args.pop();
	followCall(args, callback);
};