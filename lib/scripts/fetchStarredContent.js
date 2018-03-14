import apiCall from './api';

function fetchStarredContentCall(callback) {
	apiCall("fetchStarredContent", {},
	function (response) {
		callback(response.data);
	});
};

export default function() {
	fetchStarredContentCall();
};