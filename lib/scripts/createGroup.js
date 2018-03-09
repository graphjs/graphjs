import apiCall from './api.js';

function createGroupCall(args) {
	apiCall("createGroup", {
		"title": args[0],
		"description": args[1]
	},
	function (response) {
		console.log(response);
	});
};

export default function() {
	createGroupCall(arguments);
};