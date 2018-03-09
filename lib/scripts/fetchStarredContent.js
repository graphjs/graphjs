import apiCall from './api';

function fetchStarredContentCall() {
	apiCall("fetchStarredContent", {},
	function (response) {
		console.log(response);
	});
};

export default function() {
	fetchStarredContentCall();
};