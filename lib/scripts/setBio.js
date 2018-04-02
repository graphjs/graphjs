import apiCall from './api';

function setBioCall(args, callback) {
	apiCall("setProfile", {
		"about": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	setBioCall(args, callback);
};