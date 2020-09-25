import apiCall from './api.js';

export default function(url) {
	return apiCall("star", {
		"url": url
	});
};
