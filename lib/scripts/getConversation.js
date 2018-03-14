import apiCall from './api.js';

function getConversationCall(args, callback) {
	apiCall("getConversation", {
		"with": args[0]
	},
	function (response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	var callback = args.pop();
	getConversationCall(args, callback);
};