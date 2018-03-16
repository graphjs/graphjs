import apiCall from './api';

function logoutCall(callback) {
	apiCall("logout", {},
	function (response) {
		callback(response.data);
	});
};

export default function(callback) {
	logoutCall(callback);
};