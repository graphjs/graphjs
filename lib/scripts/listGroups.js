import apiCall from './api';

function listGroupsCall(callback) {
	return apiCall("listGroups", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	return listGroupsCall(callback);
};