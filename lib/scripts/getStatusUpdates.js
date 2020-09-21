import apiCall from './api.js';
import metadata from '../../metadata/index';
import { transformFeedItem } from './getStatusUpdate';

function getStatusUpdatesCall(offset, count, callback) {
	return apiCall("getStatusUpdates", {"offset": offset, "count": count},
	function(response) {
		callback(response.data);
	});
};

export default function(offset, count, callback) {
	//getStatusUpdatesCall(offset, count, callback);
	return middleware(offset, count, callback); // Temporary
};

// Middleware
import getBlogPosts from './getBlogPosts';
import handleInactive from './handleInactive.js';
function middleware(offset, count, callback) {
	return getBlogPosts("desc", count, offset,
		function(response) {
			handleInactive(response);
			response.updates = [];
			response.blogs.forEach(item => {
				response.updates.push(transformFeedItem(item));
			});
			delete response.blogs;
			callback(response);
		}
	);
}