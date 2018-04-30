import getUser from './getUser.js';

function getSessionCall(callback) {
	let id;
	let cookies = document.cookie.split(';');
	if (cookies.filter(function(item) {
	    return item.indexOf('graphjs_id=') >= 0;
	}).length) {
		for(let cookie of cookies) {
			let data = cookie.split('=');
			if(data[0] == 'graphjs_id') {
				id = data[1];
			}
		}
		let response = {
			"success": true,
			"id": id
		};
		console.log('with cookie', response);
		callback(response);
	} else {
		getUser(function(response) {
			if(response.success) {
				let expiry = new Date();
	  			expiry.setTime(expiry.getTime() + (10 * 60 * 1000));
			    document.cookie = 'graphjs_id=' + response.data.id + '; path=/; expires=' + expiry.toGMTString();
			}
			console.log('without cookie', response);
			callback(response);
		});
	}
};

export default function(callback) {
	getSessionCall(callback);
};