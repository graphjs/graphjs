import apiCall from './api';

function fetchInboxCall() {
	apiCall("fetchInbox", {},
	function (response) {
		console.log(response);
	});
};

export default function() {
	fetchInboxCall();
};