import apiCall from './api.js';

function getProfileCall(args) {
	apiCall("getProfile", {
		"id": args[0]
	},
	function (response) {
		console.log(response);
	});
};

export default function() {
	getProfileCall(arguments);
};