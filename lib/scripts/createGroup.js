import apiCall from './api.js';

function createGroupCall(args, callback) {
	apiCall("createGroup", {
		"title": args[0],
		"description": args[1]
	},
	function (response) {
		callback(response);
	});
};

export default function() {
	var callback = arguments.pop();
	createGroupCall(arguments, callback);
};
