import apiCall from './api.js';

function editPrivateContentCall(args, callback) {
	apiCall("editPrivateContent", {
        "id": args[0],
		"data": args[1]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	editPrivateContentCall(args, callback);
};