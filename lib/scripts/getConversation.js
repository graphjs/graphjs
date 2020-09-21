import apiCall from './api.js';

function getConversationCall(args, callback) {
	return apiCall("getConversation", {
		"with": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	return getConversationCall(args, callback);
};