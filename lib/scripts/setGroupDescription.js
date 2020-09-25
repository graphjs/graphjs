import apiCall from './api';

export default function(id, description) {
	return apiCall("setGroup", {
		"id": id,
		"description": description
	});
};
