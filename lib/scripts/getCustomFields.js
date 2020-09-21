import apiCall from './api.js';

function getCustomFieldsCall(callback) {
	return apiCall("getCustomFields", {},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return getCustomFieldsCall(callback);
};