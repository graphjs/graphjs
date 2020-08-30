import apiCall from './api.js';

function tokenLoginCall(args, callback) {
	window.GraphJS.events.emit("beforeLogin");
	apiCall("tokenLogin", {
		"token": args[0]
	},
	function(response) {
		if(response.data.success) {
			let key = (window && window.hasOwnProperty('GraphJSConfig')) ? window.GraphJSConfig.id.replace(/-/g, '') : undefined;
			let expiry = new Date();
  			expiry.setTime(expiry.getTime() + (10 * 60 * 1000));
			document.cookie = 'graphjs_' + key + '_id=' + response.data.id + '; path=/; expires=' + expiry.toGMTString() + '; samesite=none';
			document.cookie = 'graphjs_' + key + 'username=' + response.data.username + '; path=/; expires=' + expiry.toGMTString() + '; samesite=none';
			document.cookie = 'graphjs_' + key + '_session_off=; path=/; expires=Thu, 01 Jan 1970 00:00:01 GMT;' + '; samesite=none';
			window.GraphJS.events.emit("afterLogin", args);
		}
		callback(response.data);
	}, false);
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	tokenLoginCall(args, callback);
};
