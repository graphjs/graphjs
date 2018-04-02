import apiCall from './api';

function setProfileCall(args, callback) {
	apiCall("setProfile", {
		"avatar": args[0],
		"birthday": args[1],
		"about": args[2],
		"username": args[3],
		"email": args[4]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	setProfileCall(args, callback);
};