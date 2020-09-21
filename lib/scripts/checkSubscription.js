import apiCall from './api.js';

function checkSubscriptionCall(args, callback) {
	return apiCall("checkSubscription", {
		"username": args[0]
	},
	function(response) {
		callback(response.data);
	}, false);
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return checkSubscriptionCall(args, callback);
};
