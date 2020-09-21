export default function(username, id) {
  let key = (window && window.hasOwnProperty('GraphJSConfig')) ? window.GraphJSConfig.id.replace(/-/g, '') : undefined;
  let expiry = new Date();
  expiry.setTime(expiry.getTime() + (10 * 60 * 1000));
  let secure = (location.protocol === 'https:') ? " secure;" : "";
  window.document.cookie = 'graphjs_' + key + '_session_off=; path=/; expires=Thu, 01 Jan 1970 00:00:01 GMT;' + ' samesite=none;' + secure;
  window.document.cookie = 'graphjs_' + key + '_id=' + id + '; path=/; expires=' + expiry.toGMTString() + '; samesite=none;' + secure;;
  window.document.cookie = 'graphjs_' + key + '_username=' + username + '; path=/; expires=' + expiry.toGMTString() + '; samesite=none;' + secure;;
}