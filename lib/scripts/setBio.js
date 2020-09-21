import apiCall from './api';

function setBioCall(args, callback) {
	return 	apiCall("setProfile", {
		"about": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return 	setBioCall(args, callback);
};