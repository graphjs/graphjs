import apiCall from './api';

function deletePrivateContentCall(args, callback) {
	apiCall("deletePrivateContent", {
	    "id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
    let args = Array.from(arguments);
	let callback = args.pop();
	deletePrivateContentCall(args, callback);
};