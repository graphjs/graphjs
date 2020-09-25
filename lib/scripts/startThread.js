import apiCall from './api.js';

export default function(title, message) {
	return apiCall("startThread", {
		"title": title,
		"message": message
	});
};
