import axios from 'axios';

var instance = axios.create({
    baseURL: 'http://phonetworks.com:1338',
    timeout: 20000,
    headers: {'Content-Type': 'application/json'}
});

export default function(method, args, callback) {
    var _call = `/${method}?`;
    for(var key in args) {
        _call += key + '=' + encodeURI(args[key]) + '&';
    }
    _call += 'public_id=' + window.status;
    instance.get(_call, {withCredentials: true})
        .then(callback)
        .catch(function (error) {
            console.log(error);
        }
    );
};