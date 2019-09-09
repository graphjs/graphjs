import apiCall from './api.js';

function deleteGroupCall(args, callback) {
	apiCall("deleteGroup", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	deleteGroupCall(args, callback);
};
