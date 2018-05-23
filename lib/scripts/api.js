import axios from 'axios';

export default function(method, args, callback) {
    console.log('version:', 1)
    console.log('window.status:', window.status)
    console.log('window.status 2nd parameter:', window.status.split(/:(.+)/)[1])
    var instance = axios.create({
        baseURL: window.status.split(/:(.+)/)[1],
        timeout: 20000,
        headers: {'Content-Type': 'application/json'}
    });
    var _call = `/${method}?`;
    for(var key in args) {
        _call += key + '=' + encodeURI(args[key]) + '&';
    }
    _call += 'public_id=' + window.status.split(/:(.+)/)[0];
    instance.get(_call, {withCredentials: true})
        .then(callback)
        .catch(function (error) {
            console.log(error);
        }
    );
};