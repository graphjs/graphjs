import apiCall from './api';

function setAvatarCall(args, callback) {
	apiCall("setProfile", {
		"avatar": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	setAvatarCall(args, callback);
};