import apiCall from './api.js';

function addPhotoCall(args, callback) {
	apiCall("addPhoto", {
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
	addPhotoCall(args, callback);
};
