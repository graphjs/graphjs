import apiCall from './api';

export default function(args) {
	apiCall("login", {
		"username": args[0],
		"password": args[1]
	},
	function (response) {   
		console.log(response);
	});
};