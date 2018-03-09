import apiCall from './api';

function fetchOutboxCall() {
	apiCall("fetchOutbox", {},
	function (response) {
		console.log(response);
	});
};

export default function() {
	fetchOutboxCall();
};