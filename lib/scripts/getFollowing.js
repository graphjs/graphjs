import apiCall from './api.js';

function getFollowingCall(args, callback) {
	apiCall("getFollowing", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	var callback = args.pop();
	getFollowingCall(args, callback);
};