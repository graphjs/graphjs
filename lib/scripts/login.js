import apiCall from './api.js';

function loginCall(args, callback) {
	apiCall("login", {
		"username": args[0],
		"password": args[1]
	},
	function(response) {
		if(response.data.success) {
			let key = (window && window.hasOwnProperty('GraphJSConfig')) ? window.GraphJSConfig.id.replace(/-/g, '') : undefined;
			let expiry = new Date();
  			expiry.setTime(expiry.getTime() + (10 * 60 * 1000));
		    document.cookie = 'graphjs_' + key + '_id=' + response.data.id + '; path=/; expires=' + expiry.toGMTString();
			document.cookie = 'graphjs_' + key + '_session_off=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
		}
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	loginCall(args, callback);
};
