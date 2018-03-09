import apiCall from './api.js';

function joinGroupCall(args) {
	apiCall("joinGroup", {
		"id": args[0]
	},
	function (response) {
		console.log(response);
	});
};

export default function() {
	joinGroupCall(arguments);
};