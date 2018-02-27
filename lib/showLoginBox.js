import PromiseWindow from 'promise-window';

export default function(args) {

PromiseWindow.open('http://popup.html').then(
 
    // Success
    function(data) {
      // data.result == 'awesome' (1)
    },
   
    // Error
    function(error) {
      switch(error) {
        case 'closed':
          // window has been closed
          break;
        case 'my-custom-message':
          // 'my-custom-message' postMessage has been sent from target URL (2)
          break;
      }
    }
  );
};