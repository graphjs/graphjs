import apiCall from './api';

function logoutCall() {
	apiCall("logout", {},
	function (response) {
		console.log(response);
	});
};

export default function() {
	logoutCall();
};