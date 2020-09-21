import apiCall from './api';

function getStarsCall(callback) {
	return apiCall("getStarredContent", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	return getStarsCall(callback);
};