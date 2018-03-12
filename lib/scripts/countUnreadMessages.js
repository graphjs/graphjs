import apiCall from './api';

function countUnreadMessagesCall() {
	apiCall("countUnreadMessages", {},
	function (response) {
		console.log(response);
	});
};

export default function() {
	countUnreadMessagesCall();
};