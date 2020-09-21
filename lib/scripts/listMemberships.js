import apiCall from './api.js';

function listMembershipsCall(args, callback) {
	return apiCall("listMemberships", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return listMembershipsCall(args, callback);
};