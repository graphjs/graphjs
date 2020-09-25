import apiCall from './api';

export default function(email) {
	return apiCall("setProfile", {
		"email": email
	});
};

