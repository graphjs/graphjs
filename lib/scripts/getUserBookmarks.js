import apiCall from './api';

function getUserBookmarksCall(callback) {
	apiCall("getMyStarredContent", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	getUserBookmarksCall(callback);
};