import riot from 'riot';

function createTag(component, specs) {
    let tag = document.createElement('graphjs-' + component);
    for(let key of Object.keys(specs)) {
        let attribute = document.createAttribute(key);
        attribute.value = specs[key];
        tag.setAttributeNode(attribute);
    }
    return tag;
}

export default function(component, specs, display) {
    let tag = createTag(component, specs);
    display.innerHTML = '';
    display.appendChild(tag);
    riot.mount(tag);
}