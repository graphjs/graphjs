import apiCall from './api';
import handleInactive from './handleInactive';

function getMembersCall(callback) {
	apiCall("getMembers", {},
	function(response) {
		handleInactive(response);
		callback(response.data);
	});
};

export default function(callback) {
	getMembersCall(callback);
};