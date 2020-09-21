import apiCall from './api';

function setPasswordCall(args, callback) {
	return apiCall("setProfile", {
		"password": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	setPasswordCall(args, callback);
};