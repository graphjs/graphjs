import apiCall from './api.js';

export default function(username) {
	return apiCall("checkSubscription", {
		"username": username,
	});
};
