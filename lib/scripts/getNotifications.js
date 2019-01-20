import apiCall from './api';

function getNotificationsCall(callback) {
	apiCall("getNotifications", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	getNotificationsCall(callback);
};