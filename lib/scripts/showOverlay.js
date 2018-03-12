import riot from 'riot';

export default function(tagName, specs) {
    // Remove previous overlay
    let previousOverlayItem = document.querySelector('graphjs-overlay');
    previousOverlayItem && previousOverlayItem.parentNode.removeChild(previousOverlayItem);
    // Create new overlay
    let newOverlayItem = document.createElement('graphjs-overlay');
    // Set component property on overlay
    let component = document.createAttribute('component');
    component.value = tagName;
    newOverlayItem.setAttributeNode(component);
    // Set specs of component on overlay
    if(specs) {
        for(let key of Object.keys(specs)) {
            let attribute = document.createAttribute(key);
            attribute.value = specs[key];
            newOverlayItem.setAttributeNode(attribute);
        }
    }
    // Mount & append overlay
    riot.mount(newOverlayItem);
    document.body.appendChild(newOverlayItem);
}