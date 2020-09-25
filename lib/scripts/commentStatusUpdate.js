import apiCall from './api.js';

export default function(id, content) {
	return apiCall("addComment", {
		"id": id,
		"content": content
	});
};