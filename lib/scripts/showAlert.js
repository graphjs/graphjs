import showOverlay from './showOverlay.js';
const tagName = 'graphjs-alert';

export default function(specs) {
	console.log(specs)
	showOverlay(tagName, specs);
}