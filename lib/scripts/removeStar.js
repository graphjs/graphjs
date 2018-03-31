import apiCall from './api.js';

function removeStarCall(args, callback) {
	apiCall("unstar", {
		"url": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	var callback = args.pop();
	removeStarCall(args, callback);
};