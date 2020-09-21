import apiCall from './api';
const Q = require("q");

export default function(callback) {
	var def = Q.defer();
	window.GraphJS.events.emit("beforeLogout");
	let _call = apiCall("logout", {},
	function(response) {
		if(response.data.success) {
			_clearCookies();
			window.GraphJS.events.emit("afterLogout");
		}
		callback(response.data);
	}, false);
	_call.then(response) 
	{
		if(response.data.success) {
			_clearCookies();
			window.GraphJS.events.emit("afterLogout");
		}
		def.resolve(response.data);
	}
	_call.catch(err) 
	{
		def.reject(err);
	};
	return def.promise;
};

function _clearCookies() {
	let key = (window && window.hasOwnProperty('GraphJSConfig')) ? window.GraphJSConfig.id.replace(/-/g, '') : undefined;
	document.cookie = 'graphjs_' + key + '_id=; path=/; expires=Thu, 01 Jan 1970 00:00:01 GMT; samesite=none; secure;';
	document.cookie = 'graphjs_' + key + '_username=; path=/; expires=Thu, 01 Jan 1970 00:00:01 GMT; samesite=none; secure;';
	document.cookie = 'graphjs_' + key + '_session_off=true; path=/; samesite secure;';
}