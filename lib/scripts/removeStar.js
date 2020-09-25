import apiCall from './api.js';

export default function(url) {
	return 	apiCall("unstar", {
		"url": url
	});
};
