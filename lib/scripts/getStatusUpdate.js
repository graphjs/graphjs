import apiCall from './api.js';
import metadata from '../../metadata/index';

function getStatusUpdateCall(args, callback) {
	return 	apiCall("getStatusUpdate", {
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
	return middleware(args, callback); // Temporary
};

export function transformFeedItem(feedItem) {
	let id = feedItem.id;
	let author = feedItem.author;
	let timestamp = feedItem.start_time;
	let comment_count = feedItem.comment_count;
	let summary = feedItem.summary;
	// Extract title information
	let title;
	let titlePattern = /\[title\](.*?)\[\/title\]/;
	let titleMatch = titlePattern.exec(summary);
	if(titleMatch) {
			title = titleMatch[1];
			summary = summary.replace(titleMatch[0], '').trim();
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

	let preview_url = null;
	if (urls.length) {
		let decoded =  metadata.decode('\n' + text);
		let metas = decoded.metadata;
		let previewMeta = metas.find(m => m.key === urls[0] && m.type === 'preview_url');
		preview_url = previewMeta ? previewMeta.value : null;
		text = decoded.content;
	}
	return {id, type, title, text, urls, author, timestamp, comment_count, preview_url};
};

// Middleware
import getBlogPost from './getBlogPost';
function middleware(args, callback) {
	return getBlogPost(args[0], function(response) {
		response.update = transformFeedItem(response.blog);
		delete response.blog;
		callback(response);
	});
}