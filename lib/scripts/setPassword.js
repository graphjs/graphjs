import apiCall from './api';

export default function(password) {
	return apiCall("setProfile", {
		"password": password
	});
};
