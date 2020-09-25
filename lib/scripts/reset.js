import apiCall from './api.js';

export default function(email) {
	return 	apiCall("resetPassword", {
		"email": email
	});
};
