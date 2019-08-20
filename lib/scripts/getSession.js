import getUser from './getUser.js';

function getSessionCall(callback) {
	let key = (window && window.hasOwnProperty('GraphJSConfig')) ? window.GraphJSConfig.id.replace(/-/g, '') : undefined;
	let id, pending;
	let cookies = document.cookie.replace(/\s+/g, '').split(';');
	if (cookies.filter(
		function(item) {
	    	return item.indexOf('graphjs_' + key + '_id=') >= 0;
		}
	).length) {
		for(let cookie of cookies) {
			let data = cookie.split('=');
			if(data[0] == 'graphjs_' + key + '_id') {
				id = data[1];
			}
			else if(data[0] == 'graphjs_' + key + '_pending') {
				pending = new Boolean(data[1]);
			}
		}
		let response = {
			"success": true,
			"id": id,
			"pending": pending
		};
		callback(response);
	} else {
		if (cookies.filter(
			function(item) {
		    	return item.indexOf('graphjs_' + key + '_session_off=') >= 0;
			}
		).length) {
			let response = {
				"success": false,
				"reason": "No active session"
			}
			callback(response);
		} else {
			getUser(function(response) {
				if(response.success) {
					let expiry = new Date();
		  			expiry.setTime(expiry.getTime() + (10 * 60 * 1000));
					document.cookie = 'graphjs_' + key + '_id=' + response.id + '; path=/; expires=' + expiry.toGMTString();
					document.cookie = 'graphjs_' + key + '_pending=' + response.pending + '; path=/; expires=' + expiry.toGMTString();
				} else {
					document.cookie = 'graphjs_' + key + '_session_off=true; path=/;';
				}
				callback(response);
			});
		}
	}
};

export default function(callback) {
	getSessionCall(callback);
};