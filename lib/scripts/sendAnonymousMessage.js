import apiCall from './api.js';

export default function(sender, to, message) {
	return 	apiCall("sendAnonymousMessage", {
		"sender": sender,
		"to": to,
		"message": message
	});
};

