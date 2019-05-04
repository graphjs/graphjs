import apiCall from './api.js';
import metadata from '../../metadata/index';
import { transformFeedItem } from './getStatusUpdate';

function getStatusUpdatesCall(offset, count, callback) {
	apiCall("getStatusUpdates", {"offset": offset, "count": count},
	function(response) {
		callback(response.data);
	});
};

export default function(offset, count, callback) {
	//getStatusUpdatesCall(offset, count, callback);
	middleware(offset, count, callback); // Temporary
};

// Middleware
import getBlogPosts from './getBlogPosts';
function middleware(offset, count, callback) {
	getBlogPosts("desc", count, offset,
		function(response) {
			response.updates = [];
			response.blogs.forEach(item => {
				response.updates.push(transformFeedItem(item));
			});
			delete response.blogs;
			callback(response);
		}
	);
}