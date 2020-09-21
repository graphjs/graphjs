import apiCall from './api';

function setBirthdayCall(args, callback) {
	return apiCall("setProfile", {
		"birthday": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return setBirthdayCall(args, callback);
};