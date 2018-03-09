import apiCall from './api.js';

function listMembersCall(args) {
	apiCall("listMembers", {
		"id": args[0]
	},
	function (response) {
		console.log(response);
	});
};

export default function() {
	listMembersCall(arguments);
};