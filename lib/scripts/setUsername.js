import apiCall from './api';

function setUsernameCall(args, callback) {
	return apiCall("setProfile", {
		"username": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return setUsernameCall(args, callback);
};