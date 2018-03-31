import apiCall from './api';

function getConversationsCall(callback) {
	apiCall("getConversations", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	getConversationsCall(callback);
};