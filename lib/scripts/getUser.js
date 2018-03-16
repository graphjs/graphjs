import apiCall from './api';

function getUserCall(callback) {
	apiCall("whoami", {},
	function (response) {
		callback(response.data);
	});
};

export default function(callback) {
	getUserCall(callback);
};