import apiCall from './api';

function setBirthdayCall(args, callback) {
	apiCall("setProfile", {
		"birthday": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	setBirthdayCall(args, callback);
};