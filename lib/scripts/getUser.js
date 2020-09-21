import apiCall from './api';

function getUserCall(callback) {
	return 	apiCall("whoami", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	return 	getUserCall(callback);
};