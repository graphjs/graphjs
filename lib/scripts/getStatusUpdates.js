import apiCall from './api.js';
import metadata from '../../metadata/index';
import { transformFeedItem } from './getStatusUpdate';

function getStatusUpdatesCall(callback) {
	apiCall("getStatusUpdates", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	//getStatusUpdatesCall(callback);
	middleware(callback); // Temporary
};

// Middleware
import getBlogPosts from './getBlogPosts';
function middleware(callback) {
	getBlogPosts(
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