import apiCall from './api.js';

export default function(to, message) {
	return apiCall("sendMessage", {
		"to": to,
		"message": message
	});
};

