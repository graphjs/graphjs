import apiCall from './api';

function countUnreadMessagesCall(callback) {
	return apiCall("countUnreadMessages", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	return countUnreadMessagesCall(callback);
};