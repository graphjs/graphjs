import apiCall from './api.js';

function replyThreadCall(args) {
	apiCall("replyThread", {
		"id": args[0],
		"message": args[1]
	},
	function (response) {
		console.log(response);
	});
};

export default function() {
	replyThreadCall(arguments);
};