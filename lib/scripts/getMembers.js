import apiCall from './api';

function getMembersCall(callback) {
	apiCall("getMembers", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	getMembersCall(callback);
};