import apiCall from './api.js';

function listMembershipsCall(args, callback) {
	apiCall("listMemberships", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	var callback = args.pop();
	listMembershipsCall(args, callback);
};