import apiCall from './api';

export default function(id, cover) {
	return apiCall("setGroup", {
		"id": id,
		"cover": cover
	});
};

