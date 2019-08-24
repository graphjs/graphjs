import apiCall from './api';
import handleInactive from './handleInactive';

function getThreadsCall(args, callback) {
	var order = "desc";
	var count = 20;
	var offset = 0;
	console.log(args)
	if(args.length>0) {
		order = args[0];
		if(args.length>1) {
			count = args[1];
			if(args.length>2) {
				offset = args[2];
			}
		}
	}
	console.log(offset)
	apiCall("getThreads", {
		"order": order,
		"count": count,
		"offset": offset
	},
	function(response) {
		handleInactive(response);
		callback(response.data);
	});
};

export default function() {
	let args = Array.from(arguments);
	let callback = args.pop();
	getThreadsCall(args, callback);
};