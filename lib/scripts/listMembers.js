import apiCall from './api.js';

export default function(id) {
	return 	apiCall("listMembers", {
		"id": id
	});
};
