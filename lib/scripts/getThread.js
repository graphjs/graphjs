import apiCall from './api.js';

function getThreadCall(args) {
	apiCall("getThread", {
		"id": args[0]
	},
	function (response) {
		console.log(response);
	});
};

export default function() {
	getThreadCall(arguments);
};