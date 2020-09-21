import apiCall from './api';

function getOutboxCall(callback) {
	return 	apiCall("getOutbox", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	return 	getOutboxCall(callback);
};