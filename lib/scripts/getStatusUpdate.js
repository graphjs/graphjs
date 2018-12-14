import apiCall from './api.js';

function getStatusUpdateCall(args, callback) {
	apiCall("getStatusUpdate", {
		"id": args[0]
	},
	function(response) {
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	//getStatusUpdatesCall(args, callback);
	middleware(args, callback); // Temporary
};

// Middleware
import getBlogPost from './getBlogPost';
function middleware(args, callback) {
	let id = args[0]
	getBlogPost(id, function(response) {
		let item = response.blog;
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
		response.update = {id, type, text, urls, author, timestamp, comment_count};
		delete response.blog;
		callback(response);
	});
}