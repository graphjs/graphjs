import apiCall from './api';

function whoamiCall(callback) {
	apiCall("whoami", {},
	function (response) {
		callback(response.data);
	});
};

export default function() {
	whoamiCall();
};