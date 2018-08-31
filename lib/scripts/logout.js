import apiCall from './api';

function logoutCall(callback) {
	apiCall("logout", {},
	function(response) {
		if(response.data.success) {
			let key = (window && window.hasOwnProperty('GraphJSConfig')) ? window.GraphJSConfig.id.replace(/-/g, '') : undefined;
			document.cookie = 'graphjs_' + key + '_id=; path=/; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
			document.cookie = 'graphjs_' + key + '_session_off=true; path=/;';
			window.GraphJS.events.emit("afterLogout", args);
		}
		callback(response.data);
	}, false);
};

export default function(callback) {
	logoutCall(callback);
};