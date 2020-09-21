import axios from 'axios';
const Q = require("q");

function ucfirst(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

function ApiCall(method, args, callback, emitPostSignal){
    var def = Q.defer();
    var instance = axios.create({
        baseURL: window.GraphJSConfig.host,
        timeout: 20000,
        withCredentials: true,
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        maxRedirects: 3
    });

    instance.post(`/${method}?public_id=${window.GraphJSConfig.id}`, JSON.stringify(args))
        .then(function(response) {
            callback(response);
            def.resolve(response);
            if(emitPostSignal)
                window.GraphJS.events.emit("after" + ucfirst(method), args);
        })
        .catch(function (error) {
            console.log(error);
            def.reject(error);
        });
    
    return def.promise;
}

export default function(method, args, callback, emitPostSignal = true) {
    const beforeEventsExist = Object.keys(window.GraphJS.events.events).indexOf("before" + ucfirst(method)) != -1;
    if(beforeEventsExist){
        window.GraphJS.events.emit("before" + ucfirst(method), args,function(goToNextStep = true) {
            if(goToNextStep){
                return ApiCall(method, args, callback, emitPostSignal);
            }
        });
    } else {
        return ApiCall(method, args, callback, emitPostSignal);
    }
}