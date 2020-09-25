import apiCall from './api';

export default function(about) {
	return 	apiCall("setProfile", {
		"about": about
	});
};

