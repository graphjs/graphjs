import apiCall from './api.js';

function fetchMessageCall(args) {
	apiCall("fetchMessage", {
		"msgid": args[0]
	},
	function (response) {
		console.log(response);
	});
};

export default function() {
	fetchMessageCall(arguments);
};