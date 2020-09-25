import apiCall from './api';

export default function(username) {
	return apiCall("setProfile", {
		"username": username
	});
};
