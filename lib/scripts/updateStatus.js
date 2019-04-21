import apiCall from './post.js';

import metadata from '../../metadata/index.js';

function updateStatusCall(args, callback) {
	apiCall("updateStatus", {
		"type": args[0],
		"message": args[1],
		"content": args[2]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	//updateStatusCall(args, callback);
	middleware(args, callback); // Temporary
};

// Middleware
import startBlogPost from './startBlogPost';
function middleware(args, callback) {
	let type = args[0];
	let message = args[1];
	let links = args[2];
	let metas = args[3];
	let metaStr = metadata.encode({
		metadata: metas,
	});
	let markdown = '';
	if(links.length > 0) {
		markdown = '[' + type + '](' + links.join('|') + ')';
	}
	let result = (message + ' ' + markdown).trim();
	result += metaStr;
	startBlogPost(
		'feed', // Title
		result, // Content
		function(response) {
			callback(response);
		}
	);
}