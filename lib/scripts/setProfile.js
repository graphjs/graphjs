import apiCall from './api';

export default function(avatar, birthday, about, username, email) {
	return apiCall("setProfile", {
		"avatar": avatar,
		"birthday": birthday,
		"about": about,
		"username": username,
		"email": email
	});
};
