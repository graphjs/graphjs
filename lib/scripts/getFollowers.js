import apiCall from './api.js';

function getFollowersCall(args, callback) {
	apiCall("getFollowers", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	var callback = args.pop();
	getFollowersCall(args, callback);
};