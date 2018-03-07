import apiCall from './api';

function whoamiCall() {
	apiCall("whoami", {},
	function (response) {
		console.log(response);
	});
};

export default function() {
	whoamiCall();
};