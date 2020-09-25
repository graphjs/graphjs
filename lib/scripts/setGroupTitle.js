import apiCall from './api';

export default function(id, title) {
	return apiCall("setGroup", {
		"id": id,
		"title": title
	});
};

