import apiCall from './api';

function getStarsCall(callback) {
	apiCall("getStarredContent", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	getStarsCall(callback);
};