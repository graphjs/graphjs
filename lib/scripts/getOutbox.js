import apiCall from './api';

function getOutboxCall(callback) {
	apiCall("getOutbox", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	getOutboxCall(callback);
};