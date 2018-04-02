import apiCall from './api.js';

function getStarCall(args, callback) {
	apiCall("isStarred", {
		"url": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	getStarCall(args, callback);
};