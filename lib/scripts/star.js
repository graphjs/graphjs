import apiCall from './api.js';

function starCall(args, callback) {
	apiCall("star", {
		"url": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	var callback = args.pop();
	starCall(args, callback);
};