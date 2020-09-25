import apiCall from './api.js';

export default function() {
	return apiCall("getCustomFields", {});
};