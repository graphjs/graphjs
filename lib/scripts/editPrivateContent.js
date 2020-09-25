import apiCall from './api.js';

export default function(id, data) {
	return apiCall("editPrivateContent", {
        "id": id,
		"data": data
	});
};
