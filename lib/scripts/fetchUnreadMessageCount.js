import apiCall from './api';

function fetchUnreadMessageCountCall() {
	apiCall("fetchUnreadMessageCount", {},
	function (response) {
		console.log(response);
	});
};

export default function() {
	fetchUnreadMessageCountCall();
};