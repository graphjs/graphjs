import apiCall from './api';

export default function(id) {
	return 	apiCall("getPrivateContent", {
	    "id": id
	});
};
