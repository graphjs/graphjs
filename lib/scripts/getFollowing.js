import apiCall from './api.js';

function getFollowingCall(args, callback) {
	return apiCall("getFollowing", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return getFollowingCall(args, callback);
};