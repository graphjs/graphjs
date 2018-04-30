import apiCall from './api.js';

function loginCall(args, callback) {
	apiCall("login", {
		"username": args[0],
		"password": args[1]
	},
	function(response) {
		if(response.data.success ) {
		    document.cookie = "id="+response.data.id+"; path=/";
		}
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	loginCall(args, callback);
};
