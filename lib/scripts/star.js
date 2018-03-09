import apiCall from './api.js';

function starCall(args) {
	apiCall("star", {
		"url": args[0]
	},
	function (response) {
		console.log(response);
	});
};

export default function() {
	starCall(arguments);
};