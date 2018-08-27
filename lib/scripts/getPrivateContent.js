import apiCall from './api';

function getPrivateContentCall(args, callback) {
	apiCall("getPrivateContent", {
	    "id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
    let args = Array.from(arguments);
	let callback = args.pop();
	getPrivateContentCall(args, callback);
};