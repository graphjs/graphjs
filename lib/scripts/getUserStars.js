import apiCall from './api';

function getUserStarsCall(callback) {
	return 	apiCall("getMyStarredContent", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	return 	getUserStarsCall(callback);
};