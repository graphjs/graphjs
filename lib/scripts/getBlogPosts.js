import apiCall from './api';

function getBlogPostsCall(callback) {
	apiCall("getBlogPosts", {},
	function(response) {
		callback(response.data);
	});
};

export default function(callback) {
	getBlogPostsCall(callback);
};