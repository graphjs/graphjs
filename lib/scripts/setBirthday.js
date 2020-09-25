import apiCall from './api';

export default function(birthday) {
	return apiCall("setProfile", {
		"birthday": birthday
	});
};

