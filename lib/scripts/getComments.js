import apiCall from './api.js';

function getCommentsCall(args, callback) {
	apiCall("getComments", {
		"url": args[0]
	},
	function (response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	var callback = args.pop();
	getCommentsCall(args, callback);
};