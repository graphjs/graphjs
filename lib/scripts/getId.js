import apiCall from './api.js';

function getIdCall(args, callback) {
	apiCall("getId", {
		"ref": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	getIdCall(args, callback);
};