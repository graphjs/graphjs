import apiCall from './api.js';

export default function(url, content) {
	return apiCall("addComment", {
		"url": url,
		"content": content
	});
}