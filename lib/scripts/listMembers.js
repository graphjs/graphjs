import apiCall from './api.js';

function listMembersCall(args, callback) {
	return 	apiCall("listMembers", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return 	listMembersCall(args, callback);
};