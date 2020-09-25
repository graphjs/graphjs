import apiCall from './api.js';

export default function(id) {
	return 	apiCall("removeComment", {
		"comment_id": id
	});
};