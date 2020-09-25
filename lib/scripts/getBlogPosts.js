import apiCall from './api';

export default function(order="desc", count=20, offset=0) {
	return apiCall("getBlogPosts", {
		"order": order,
		"count": count,
		"offset": offset
	});
};
