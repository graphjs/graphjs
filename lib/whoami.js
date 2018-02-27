import apiCall from './api';

export default function() {
	apiCall("whoami", {},
	function (response) {   
		console.log(response);
	});
};