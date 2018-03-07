import apiCall from './api';

function registerCall(args) {
	apiCall("signup", {
		"username": args[0],
		"email": args[1],
		"password": args[2]
	},
	function (response) {
		console.log(response);
	});
};

export default function() {
	registerCall(arguments)
};