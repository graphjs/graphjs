import apiCall from './api';

export default function() {
	return apiCall("listGroups", {});
};