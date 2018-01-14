# graphpress

1. ```npm install```
2. edit ```node_modules/pho-js-client/src/ApiClient.js``` and change ```this.basePath``` url to ```http://83.149.67.212:1337```
3. type ```node```
4. The following code should get you a proper result:

```javascript
var phonetworks = require('pho-js-client');
var api = new phonetworks.DefaultApi();
var callback = function(error, data, response) { console.log("Works! Founder id is: " + data.id); };
api.getFounder(callback);
```

Please note, the javascript API library is from: https://github.com/pho-clients/js

Feel free to fork and edit it.
