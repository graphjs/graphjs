import apiCall from './api.js';

function createSubscriptionCall(args, callback) {
	return apiCall("createSubscription", {
		"email": args[0],
		"plan": args[1],
		"source": args[2]
	},
	function(response) {
		callback(response.data);
	}, false);
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return createSubscriptionCall(args, callback);
};
