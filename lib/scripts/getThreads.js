import apiCall from './api';

function getThreadsCall(callback) {
	apiCall("getThreads", {},
	function (response) {
		callback(response.data);
	});
};

export default function(callback) {
	getThreadsCall(callback);
};