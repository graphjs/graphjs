import apiCall from './api.js';

function getCustomFieldsCall(callback) {
	apiCall("getCustomFieklds", {},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	getCustomFieldsCall(arguments);
};