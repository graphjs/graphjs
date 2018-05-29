import getUser from './getUser.js';

function getSessionCall(callback) {
	let id;
	console.log(1, id) //TEST
	let cookies = document.cookie.split(';');
	console.log(2, cookies) //TEST
	if (cookies.filter(
		function(item) {
	    	return item.indexOf('graphjs_id=') >= 0;
		}
	).length) {
		console.log(3, cookies) //TEST
		for(let cookie of cookies) {
			console.log(4, cookie) //TEST
			let data = cookie.split('=');
			console.log(5, data) //TEST
			if(data[0] == 'graphjs_id') {
				id = data[1];
				console.log(6, id) //TEST
			}
		}
		let response = {
			"success": true,
			"id": id
		};
		console.log(7, response) //TEST
		callback(response);
	} else {
		if (cookies.filter(
			function(item) {
		    	return item.indexOf('graphjs_session_off=') >= 0;
			}
		).length) {
			let response = {
				"success": false,
				"reason": "No active session"
			}
			console.log(8, response) //TEST
			callback(response);
		} else {
			getUser(function(response) {
				console.log(9, response) //TEST
				if(response.success) {
					let expiry = new Date();
					console.log(10, expiry) //TEST
		  			expiry.setTime(expiry.getTime() + (10 * 60 * 1000));
					console.log(11, expiry) //TEST
				    document.cookie = 'graphjs_id=' + response.id + '; path=/; expires=' + expiry.toGMTString();
					console.log(12, document.cookie) //TEST
				} else {
					document.cookie = 'graphjs_session_off=true; path=/;';
					console.log(13, document.cookie) //TEST
				}
				callback(response);
			});
		}
	}
};

export default function(callback) {
	getSessionCall(callback);
};