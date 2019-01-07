import apiCall from './api.js';

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
					let id = item.id;
					let author = item.author;
					let timestamp = item.start_time;
					let comment_count = item.comment_count;
					let pattern = /\[(.*?)\]\((.*?)\)/g;
					let matches = pattern.exec(item.summary);
					let text, type, urls;
					if(matches) {
							text = item.summary.replace(matches[0], '').trim();
							type = matches[1];
							urls = matches[2] !== '' ? matches[2].split('|') : [];
					} else {
							text = item.summary.trim()
							type = 'text';
							urls = [];
					}
					response.updates.push({id, type, text, urls, author, timestamp, comment_count});
			});
			delete response.blogs;
			callback(response);
		}
	);
}