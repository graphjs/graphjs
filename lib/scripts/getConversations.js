import apiCall from './api';
import handleInactive from './handleInactive';

function getConversationsCall(callback) {
	apiCall("getConversations", {},
	function(response) {
		handleInactive(response);
		callback(response.data);
	});
};

export default function(callback) {
	getConversationsCall(callback);
};