import apiCall from './api';

export default function(args) {
	apiCall("signup", {
		"username": args[0],
		"email": args[1],
		"password": args[2]
	},
	function (response) {   
		console.log(response);
	});
};