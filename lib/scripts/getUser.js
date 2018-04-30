import apiCall from './api';

function getUserCall(callback) {
	apiCall("whoami", {},
	function(response) {
		if(response.data.success) {
			let expiry = new Date();
  			expiry.setTime(expiry.getTime() + (10 * 60 * 1000));
		    document.cookie = 'graphjs_id=' + response.data.id + '; path=/; expires=' + expiry.toGMTString();
		}
		callback(response.data);
	});
};

export default function(callback) {
	getUserCall(callback);
};