import showOverlay from './showOverlay.js';

export default function(tagName, hookName, specs) {
	window.GraphJS.events.emit("pre"+hookName, specs);
	showOverlay(tagName, specs);
	window.GraphJS.events.emit("post"+hookName, specs);
}