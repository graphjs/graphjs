import apiCall from './api';

function listGroupsCall(callback) {
	apiCall("listGroups", {},
	function (response) {
		callback(response.data);
	});
};

export default function() {
	listGroupsCall();
};