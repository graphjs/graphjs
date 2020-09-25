import apiCall from './api.js';

export default function(type, id) {
	return apiCall("generateFeedToken", {
		"type": type,
		"id": id
	});
};