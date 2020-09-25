import apiCall from './api.js';

export default function(email, code) {
	return apiCall("verifyReset", {
		"email": email,
		"code": code
	});
};
