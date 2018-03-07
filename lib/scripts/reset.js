import apiCall from './api.js';

function resetCall(args) {
	console.log(apiCall("remind", {
		"email": args[0]
	}),
	function (response) {
		console.log(response);
	});
};

export default function() {
	resetCall(arguments);
};