import apiCall from './api';

function setAvatarCall(args, callback) {
	return 	apiCall("setProfile", {
		"avatar": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return 	setAvatarCall(args, callback);
};