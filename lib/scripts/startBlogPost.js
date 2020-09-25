import apiCall from './post.js'; // Moved to POST api

export default function(title, content) {
	return apiCall("startBlogPost", {
		"title": title,
		"content": content
	});
};
