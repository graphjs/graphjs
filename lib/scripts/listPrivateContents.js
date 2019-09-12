import apiCall from './api.js';

export default function(callback) {
	apiCall("listPrivateContents", {},
	function(response) {
		callback(response.data);
	});
};