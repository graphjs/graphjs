import apiCall from './api.js';

export default function(id) {
	return apiCall("unstar", {
		"id": id
	});
};

