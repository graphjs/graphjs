import apiCall from './api';

function setGroupTitleCall(args, callback) {
	apiCall("setGroup", {
		"id": args[0],
		"title": args[1]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	setGroupTitleCall(args, callback);
};