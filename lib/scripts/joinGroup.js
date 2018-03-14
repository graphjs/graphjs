import apiCall from './api.js';

function joinGroupCall(args, callback) {
	apiCall("joinGroup", {
		"id": args[0]
	},
	function (response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	var callback = args.pop();
	joinGroupCall(args, callback);
};