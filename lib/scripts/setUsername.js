import apiCall from './api';

function setUsernameCall(args, callback) {
	apiCall("setProfile", {
		"username": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	var callback = args.pop();
	setUsernameCall(args, callback);
};