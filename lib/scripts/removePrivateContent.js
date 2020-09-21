import apiCall from './api';

function deletePrivateContentCall(args, callback) {
	return 	apiCall("deletePrivateContent", {
	    "id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
    let args = Array.from(arguments);
	let callback = args.pop();
	return deletePrivateContentCall(args, callback);
};