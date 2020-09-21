import apiCall from './api.js';

function unfollowCall(args, callback) {
	return apiCall("unfollow", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return unfollowCall(args, callback);
};