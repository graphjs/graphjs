import apiCall from './api';

function getBlogPostsCall(args, callback) {
	var order = "desc";
	if(args!=undefined) {
		order = args[0];
	}
	apiCall("getBlogPosts", {
		"order": order
	},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	let args = Array.from(arguments);
	var callback;
	if(args.length>1) {
		callback = args.pop();
	}
	else {
		callback = args[0];
		args = undefined;
	}
	getBlogPostsCall(args, callback);
};