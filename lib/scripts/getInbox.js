import apiCall from './api';

function getInboxCall(callback) {
	apiCall("getInbox", {},
	function (response) {
		callback(response);
	});
};

export default function(callback) {
	getInboxCall(callback);
};
