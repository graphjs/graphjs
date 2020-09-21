import apiCall from './api';

function setEmailCall(args, callback) {
	return apiCall("setProfile", {
		"email": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return setEmailCall(args, callback);
};