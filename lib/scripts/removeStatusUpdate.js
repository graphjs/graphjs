import apiCall from './api.js';

function removeStatusUpdateCall(args, callback) {
	return 	apiCall("removeStatusUpdate", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	//updateStatusCall(args, callback);
	return 	middleware(args, callback); //Temporary
};

// Middleware
import removeBlogPost from './removeBlogPost';
function middleware(args, callback) {
	let id = args[0]
	return removeBlogPost(id, function(response) {
		callback(response);
	});
}