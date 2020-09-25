import apiCall from './api.js';

export default function(msgid) {
	return 	apiCall("getMessage", {
		"msgid": msgid
	});
};