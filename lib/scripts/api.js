import axios from 'axios';
import axiosCookieJarSupport from 'axios-cookiejar-support';
const tough = require('tough-cookie');

axiosCookieJarSupport(axios.default)
const cookieJar = new tough.CookieJar();

function ucfirst(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

function ApiCall(method, args, callback, emitPostSignal){
    var instance = axios.create({
        baseURL: window.GraphJSConfig.host,
        timeout: 20000,
        headers: {
            'Content-Type': 'application/json'
        },
        maxRedirects: 3
    });
    var _call = `/${method}?`;
    for(var key in args) {
        _call += key + '=' + encodeURIComponent(args[key]) + '&';
    }
    _call += 'public_id=' + window.GraphJSConfig.id;
    instance.get(_call, {
        withCredentials: true,
        jar: cookieJar
    })
        .then(function(response) {
            callback(response);
            if(emitPostSignal)
                window.GraphJS.events.emit("after" + ucfirst(method), args);
        })
        .catch(function (error) {
            console.log(error);
        }
    );
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