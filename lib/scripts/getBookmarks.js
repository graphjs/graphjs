import apiCall from './api';

function getBookmarksCall(callback) {
	apiCall("fetchStarredContent", {},
	function (response) {
		callback(response.data);
	});
};

export default function() {
	getBookmarksCall();
};