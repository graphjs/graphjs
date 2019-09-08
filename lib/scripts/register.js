import apiCall from './api';

function registerCall(args, callback) {
	window.GraphJS.events.emit("beforeRegister", args);
	apiCall("signup", {
		"username": args[0],
		"email": args[1],
		"password": args[2],
		"custom_field1": args[3],
		"custom_field1": args[4],
		"custom_field1": args[5]
	},
	function(response) {
		if(response.data.success) {
			window.GraphJS.events.emit("afterRegister", args, response.data);
		}
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	registerCall(args, callback);
};