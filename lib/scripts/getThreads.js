import apiCall from './api';

function getThreadsCall() {
	apiCall("getThreads", {},
	function (response) {
		console.log(response);
	});
};

export default function() {
	getThreadsCall();
};