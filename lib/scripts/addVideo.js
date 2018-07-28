import apiCall from './api.js';

function addVideoCall(args, callback) {
	apiCall("addVideo", {
		"type": args[0],
		"message": args[1],
		"content": args[2]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	addVideoCall(args, callback);
};
