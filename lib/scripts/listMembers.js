import apiCall from './api.js';

function listMembersCall(args, callback) {
	apiCall("listMembers", {
		"id": args[0]
	},
	function (response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	var callback = args.pop();
	listMembersCall(args, callback);
};