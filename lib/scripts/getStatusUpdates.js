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
					let summary = item.summary;
					// Extract title information
					let title;
					let titlePattern = /\[title\](.*?)\[\/title\]/;
					let titleMatch = titlePattern.exec(summary);
					if(titleMatch) {
							title = titleMatch[1];
							let summary = summary.replace(titleMatch[0], '').trim();
					}
					// Extract file information
					let filePattern = /\[(.*?)\]\((.*?)\)/g;
					let fileMatch = filePattern.exec(summary);
					let text, type, urls;
					if(fileMatch) {
							text = summary.replace(fileMatch[0], '').trim();
							type = fileMatch[1];
							if(type === 'file') type = 'document';
							urls = fileMatch[2] !== '' ? fileMatch[2].split('|') : [];
					} else {
							text = summary.trim();
							type = 'text';
							urls = [];
					}
					response.updates.push({id, type, title, text, urls, author, timestamp, comment_count});
			});
			delete response.blogs;
			callback(response);
		}
	);
}