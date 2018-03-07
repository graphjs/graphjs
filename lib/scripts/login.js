import apiCall from './api.js';

function loginCall(args) {
	apiCall("login", {
		"username": args[0],
		"password": args[1]
	},
	function (response) {
		console.log(response);
	});
};

export default function() {
	loginCall(arguments);
};