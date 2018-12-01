import jsonp from 'jsonp';

const enabled = true;
const url = "https://graphjs-analytics.herokuapp.com/index.php";

export default function(tag) {
    if(!enabled)
        return;
    var _call = `${url}?`;
    _call += 'public_id=' + window.GraphJSConfig.id;
    _call += '&tag=' + tag;
    _call += '&host=' + window.location.hostname;
    jsonp(_call, null, (err, data) => {
        if(err)
            console.log(err.message);
    });  
}