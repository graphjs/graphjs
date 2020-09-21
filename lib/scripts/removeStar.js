import apiCall from './api.js';

function removeStarCall(args, callback) {
	return 	apiCall("unstar", {
		"url": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return removeStarCall(args, callback);
};