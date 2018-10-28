import apiCall from './api.js';

function checkSubscriptionCall(args, callback) {
	apiCall("checkSubscription", {
		"username": args[0]
	},
	function(response) {
		callback(response.data);
	}, false);
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	checkSubscriptionCall(args, callback);
};
