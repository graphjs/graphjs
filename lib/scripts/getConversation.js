import apiCall from './api.js';

export default function(_with) {
	return apiCall("getConversation", {
		"with": _with
	});
};
