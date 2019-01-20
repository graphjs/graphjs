import apiCall from './api';

function getNotificationsCountCall(callback) {
	apiCall("getNotificationsCount", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	getNotificationsCountCall(callback);
};