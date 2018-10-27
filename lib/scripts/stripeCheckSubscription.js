import apiCall from './api.js';

function stripeCheckSubscriptionCall(args, callback) {
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
	stripeCheckSubscriptionCall(args, callback);
};
