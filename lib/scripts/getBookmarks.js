import apiCall from './api';

function getBookmarksCall(callback) {
	apiCall("getStarredContent", {},
	function (response) {
		callback(response.data);
	});
};

export default function(callback) {
	getBookmarksCall(callback);
};