import apiCall from './api.js';

function getMessageCall(args) {
	apiCall("getMessage", {
		"msgid": args[0]
	},
	function (response) {
		console.log(response);
	});
};

export default function() {
	getMessageCall(arguments);
};