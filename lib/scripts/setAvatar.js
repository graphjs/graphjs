import apiCall from './api';

export default function(avatar) {
	return 	apiCall("setProfile", {
		"avatar": avatar
	});
};

