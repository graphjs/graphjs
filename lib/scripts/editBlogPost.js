import apiCall from './post.js';

export default function(id, title, content) {
	return apiCall("editBlogPost", {
		"id": id,
		"title": title,
		"content": content
	});
};