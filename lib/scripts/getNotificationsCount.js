import apiCall from './api';

function getNotificationsCountCall(callback) {
	return 	apiCall("getNotificationsCount", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	return getNotificationsCountCall(callback);
};