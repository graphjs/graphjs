import apiCall from './api.js';

function getFollowersCall(args, callback) {
	return apiCall("getFollowers", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return getFollowersCall(args, callback);
};