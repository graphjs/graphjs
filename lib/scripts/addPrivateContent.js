import apiCall from './api.js';

export default function(data) {
	return apiCall("addPrivateContent", {
		"data": data
	});
}
