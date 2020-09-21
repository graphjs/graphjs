import apiCall from './api';

function getInboxCall(callback) {
	return apiCall("getInbox", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	return getInboxCall(callback);
};