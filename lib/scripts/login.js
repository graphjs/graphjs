import apiCall from './api.js';

function loginCall(args, callback) {
	apiCall("login", {
		"username": args[0],
		"password": args[1]
	},
	function(response) {
		if(response.data.success) {
			let expiry = new Date();
  			expiry.setTime(expiry.getTime() + (10 * 60 * 1000));
		    document.cookie = 'graphjs_id=' + response.data.id + '; path=/; expires=' + expiry.toGMTString();
		}
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	loginCall(args, callback);
};