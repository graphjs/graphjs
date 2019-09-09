import apiCall from './api.js';
import handleLoginCookies from './_handleLoginCookies.js';

function verifyEmailCodeCall(args, callback) {
	apiCall("verifyEmailCode", {
		"id": args[0],
		"code": args[1]
	},
	function(response) {
		if(response.data.success) {
			handleLoginCookies(response.data.username, response.data.id);
			window.GraphJS.events.emit("afterLogin", args, response.data);
		}
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	verifyEmailCodeCall(args, callback);
};