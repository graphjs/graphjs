import apiCall from './api.js';

export default function(id, message) {
	return apiCall("reply", {
		"id": id,
		"message": message
	});
};