import riot from 'riot';

function createTag(name, specs) {
    let tag = document.createElement(name);
    for(let key of Object.keys(specs)) {
        let attribute = document.createAttribute(key);
        attribute.value = specs[key];
        tag.setAttributeNode(attribute);
    }
    return tag.outerHTML;
}

function createFunction(name, specs) {
    let functionSpecs = Object.keys(specs).length > 0 ? JSON.stringify(specs, null, 4) : '';
    return name + '(' + functionSpecs + ')';
}

export default function(type, name, specs, code) {
    if(type == 'component') {
        code.innerHTML = createTag(name, specs);
    } else if (type == 'function') {
        code.innerHTML = createFunction(name, specs)
    }
    code.parentNode.classList.remove('prettyprinted');
    PR.prettyPrint();
}