import apiCall from './api';

function getInboxCall(callback) {
	apiCall("getInbox", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	getInboxCall(callback);
};