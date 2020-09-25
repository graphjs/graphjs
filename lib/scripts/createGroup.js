import apiCall from './api.js';

export default function(title, description) {
	return apiCall("createGroup", {
		"title": title,
		"description": description
	});
};