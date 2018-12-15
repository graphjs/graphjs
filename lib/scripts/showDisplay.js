import riot from 'riot';

export default function(data, index) {
    //Set data
    if(!window.hasOwnProperty('GraphJSMedia')) {
        window.GraphJSMedia = {};
    }
    window.GraphJSMedia[data.id] = data;
    // Create display tag
    let display = document.createElement('graphjs-feed-display');
    // Set id attribute
    let idAttribute = document.createAttribute('id');
    idAttribute.value = data.id;
    display.setAttributeNode(idAttribute);
    // Set index attribute if exists
    if(index) {
        let indexAttribute = document.createAttribute('index');
        indexAttribute.value = index;
        display.setAttributeNode(indexAttribute);
    }
    // Mount & append tag
    riot.mount(display);
    document.body.appendChild(display);
}