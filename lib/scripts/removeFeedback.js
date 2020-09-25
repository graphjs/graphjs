import apiCall from './api.js';

export default function(id) {
	return 	apiCall("removeFeedback", {
		"feedback_id": id
	});
};
