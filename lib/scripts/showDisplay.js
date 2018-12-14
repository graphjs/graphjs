import riot from 'riot';

export default function(id, data) {
    //Set data
    if(!window.hasOwnProperty('GraphJSMedia')) {
        window.GraphJSMedia = {};
    }
    window.GraphJSMedia[id] = data;
    // Create Display
    let display = document.createElement('graphjs-feed-display');
    // Set id on Display
    let attribute = document.createAttribute('id');
    attribute.value = id;
    display.setAttributeNode(attribute);
    // Mount & append Display
    riot.mount(display);
    document.body.appendChild(display);
}
