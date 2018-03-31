import apiCall from './api';

function countUnreadMessagesCall(callback) {
	apiCall("countUnreadMessages", {},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	countUnreadMessagesCall();
};