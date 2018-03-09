import apiCall from './api.js';

function startThreadCall(args) {
	apiCall("startThread", {
		"title": args[0],
		"message": args[1]
	},
	function (response) {
		console.log(response);
	});
};

export default function() {
	startThreadCall(arguments);
};