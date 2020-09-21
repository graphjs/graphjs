import apiCall from './api.js';

export default function(callback) {
	return 	apiCall("listPrivateContents", {},
	function(response) {
		callback(response.data);
	});
};