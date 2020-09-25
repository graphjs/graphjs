import apiCall from './api.js';

export default function(id, content) {
	return apiCall("editComment", {
		"id": id,
		"content": content
	});
};