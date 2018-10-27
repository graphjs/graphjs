import showOverlay from './showOverlay.js';

export default function(tagName, hookName, specs) {
	const beforeEventsExist = Object.keys(window.GraphJS.events.events).indexOf("before"+hookName) != -1;
	if(beforeEventsExist){
		window.GraphJS.events.emit("before"+hookName, specs,function(goToNextStep = true){
			if(goToNextStep){
				showOverlay(tagName, specs);
				window.GraphJS.events.emit("after"+hookName, specs);
			}
		});
	} else {
		showOverlay(tagName, specs);
		window.GraphJS.events.emit("after"+hookName, specs);
	}
}