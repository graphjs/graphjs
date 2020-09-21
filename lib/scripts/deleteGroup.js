import apiCall from './api.js';

function deleteGroupCall(args, callback) {
	return apiCall("deleteGroup", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return deleteGroupCall(args, callback);
};
