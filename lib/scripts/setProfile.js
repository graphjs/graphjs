import apiCall from './api';

function setProfileCall(args) {
	apiCall("setProfile", {
		"avatar": args[0],
		"birthday": args[1],
		"about": args[2],
		"username": args[3]
	},
	function (response) {
		console.log(response);
	});
};

export default function() {
	setProfileCall(arguments)
};