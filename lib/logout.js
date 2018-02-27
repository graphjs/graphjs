import apiCall from './api';

export default function() {
	apiCall("logout", {},
	function (response) {   
		console.log(response);
	});
};