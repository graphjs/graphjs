import apiCall from './api';

export default function(id) {
	return 	apiCall("deletePrivateContent", {
	    "id": id
	});
};