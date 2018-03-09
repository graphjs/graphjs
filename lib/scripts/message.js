import apiCall from './api.js';

function messageCall(args) {
	apiCall("message", {
		"to": args[0],
		"message": args[1]
	},
	function (response) {
		console.log(response);
	});
};

export default function() {
	messageCall(arguments);
};