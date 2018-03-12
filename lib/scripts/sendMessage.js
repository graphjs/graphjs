import apiCall from './api.js';

function sendMessageCall(args) {
	apiCall("sendMessage", {
		"to": args[0],
		"message": args[1]
	},
	function (response) {
		console.log(response);
	});
};

export default function() {
	sendMessageCall(arguments);
};