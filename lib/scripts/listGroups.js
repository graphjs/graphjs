import apiCall from './api';

function listGroupsCall() {
	apiCall("listGroups", {},
	function (response) {
		console.log(response);
	});
};

export default function() {
	listGroupsCall();
};