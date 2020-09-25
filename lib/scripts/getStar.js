import apiCall from './api.js';

export default function(url) {
	return 	apiCall("isStarred", {
		"url": url
	});
};