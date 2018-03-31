import apiCall from './api';

function setEmailCall(args, callback) {
	apiCall("setProfile", {
		"email": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	var callback = args.pop();
	setEmailCall(args, callback);
};