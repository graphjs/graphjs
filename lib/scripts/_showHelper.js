import showOverlay from './showOverlay.js';

export default function(tagName, hookName, specs) {
	window.GraphJS.events.emit("before"+hookName, specs);
	showOverlay(tagName, specs);
	window.GraphJS.events.emit("after"+hookName, specs);
}