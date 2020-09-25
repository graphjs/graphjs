import apiCall from './api.js';

export default function(id) {
	return apiCall("getFollowers", {
		"id": id
	});
};
