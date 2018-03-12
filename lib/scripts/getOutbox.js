import apiCall from './api';

function getOutboxCall() {
	apiCall("getOutbox", {},
	function (response) {
		console.log(response);
	});
};

export default function() {
	getOutboxCall();
};