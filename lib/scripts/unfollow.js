import apiCall from './api.js';

function unfollowCall(args, callback) {
	apiCall("unfollow", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	unfollowCall(args, callback);
};