import axios from 'axios';

var instance = axios.create({
    baseURL: 'http://phonetworks.com:1338',
    timeout: 20000,
    headers: {'Content-Type': 'application/json'}
});

export default function(method, args, callback) {
    var _call = `/${method}?`;
    for(var key in args) {
        _call += key + '=' + args[key] + '&';
    }
    instance.get(_call)
        .then(callback)
        .catch(function (error) {
            console.log(error);
        }
    );
};