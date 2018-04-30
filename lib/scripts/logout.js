import apiCall from './api';

function logoutCall(callback) {
	apiCall("logout", {},
	function(response) {
		if(response.data.success) {
			document.cookie = 'graphjs_id=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
		}
		callback(response.data);
	});
};

export default function(callback) {
	logoutCall(callback);
};