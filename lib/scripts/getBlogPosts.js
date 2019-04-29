import apiCall from './api';

function getBlogPostsCall(args, callback) {
	var order = "desc";
	var count = 20;
	var offset = 0;
	if(args.length>1) {
		order = args[0];
		if(args.length>2) {
			count = args[1];
			if(args.length>3) {
				offset = args[2];
			}
		}
	}
	apiCall("getBlogPosts", {
		"order": order,
		"count": count,
		"offset": offset
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	getBlogPostsCall(args, callback);
};