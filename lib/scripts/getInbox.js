import apiCall from './api';

function getInboxCall() {
	apiCall("getInbox", {},
	function (response) {
		console.log(response);
	});
};

export default function() {
	getInboxCall();
};