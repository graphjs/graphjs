import apiCall from './api.js';

export default function(url, content, rating) {
	return apiCall("addFeedback", {
		"url": url,
		"content": content,
		"rating": rating
	});
}
