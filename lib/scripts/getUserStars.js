import apiCall from './api';

function getUserStarsCall(callback) {
	apiCall("getMyStarredContent", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	getUserStarsCall(callback);
};