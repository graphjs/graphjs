import apiCall from './api';

function getNotificationsCall(callback) {
	return 	apiCall("getNotifications", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	return getNotificationsCall(callback);
};