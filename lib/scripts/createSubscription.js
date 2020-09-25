import apiCall from './api.js';

export default function(email, plan, source) {
	return apiCall("createSubscription", {
		"email": email,
		"plan": plan,
		"source": source
	});
};
