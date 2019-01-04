import axios from 'axios';

function ucfirst(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

function ApiCall(method, args, callback, emitPostSignal){
    var instance = axios.create({
        baseURL: window.GraphJSConfig.host,
        timeout: 20000,
        withCredentials: true,
        transformRequest: [(body) => JSON.stringify(body)],
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        maxRedirects: 3
    });

    instance.post(`/${method}?public_id=${window.GraphJSConfig.id}`, args)
        .then(function(response) {
            callback(response);
            if(emitPostSignal)
                window.GraphJS.events.emit("after" + ucfirst(method), args);
        })
        .catch(function (error) {
            console.log(error);
        });
}

export default function(method, args, callback, emitPostSignal = true) {
    const beforeEventsExist = Object.keys(window.GraphJS.events.events).indexOf("before" + ucfirst(method)) != -1;
    if(beforeEventsExist){
        window.GraphJS.events.emit("before" + ucfirst(method), args,function(goToNextStep = true) {
            if(goToNextStep){
                ApiCall(method, args, callback, emitPostSignal);
            }
        });
    } else {
        ApiCall(method, args, callback, emitPostSignal);
    }
}