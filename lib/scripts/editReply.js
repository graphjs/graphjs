import apiCall from './api.js';

export default function(id, content) {
	return apiCall("editForumPost", {
		"id": id,
		"content": content
	});
};