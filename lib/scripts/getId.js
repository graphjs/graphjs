import apiCall from './api.js';

export default function(ref) {
	return apiCall("getId", {
		"ref": ref
	});
};