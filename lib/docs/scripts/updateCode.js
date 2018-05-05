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

function createShowFunction(name, specs) {
    let functionSpecs = Object.keys(specs).length > 0 ? JSON.stringify(specs, null, 4) : '';
    return name + '(' + functionSpecs + ')';
}

function createCallFunction(name, specs) {
    let functionSpecs = Object.values(specs).map(function(item) {
        return '    "' + item + '"';
    }).join(',\n');
    return name + '(\n' + functionSpecs + (Object.values(specs).length > 0 ? ',\n' : '') + '    function(response) {\n        //Do something\n    }\n)';
}

export function updateComponent(name, specs, code) {
    code.innerHTML = createTag(name, specs);
    code.parentNode.classList.remove('prettyprinted');
    PR.prettyPrint();
}

export function updateShowFunction(name, specs, code) {
    code.innerHTML = createShowFunction(name, specs);
    code.parentNode.classList.remove('prettyprinted');
    PR.prettyPrint();
}

export function updateCallFunction(name, specs, code) {
    code.innerHTML = createCallFunction(name, specs);
    code.parentNode.classList.remove('prettyprinted');
    PR.prettyPrint();
}