import languageData from '../language';

// Filter prefix
const prefix = 'lang';
// Language preference
const preference = window.GraphJSConfig.language;
// Language to be served
const language = Object.keys(languageData).includes(preference)
    ? preference
    : 'en-US';

// Removing prefix for a simpler dataset
function removePrefix(string, prefix) {
    // Remove prefix
    string = string.replace(prefix, '');
    // Make first character lowercase to make it camelCase again
    string = string.charAt(0).toLowerCase() + string.slice(1);
    // Return unprefixed string
    return string;
}

// Overwriting language object with language data from opts
export default function(tag, opts) {
    // Filter opts object with prefix
    const languageUpdates = Object.keys(opts)
        .filter(key => key.startsWith(prefix))
        .reduce((data, key) => {
            // Create filtered object
            data[removePrefix(key, prefix)] = opts[key];
            // Return secure object
            return JSON.parse(JSON.stringify(data));
        }, {});
    // Return overwritten language object
    return {...languageData[language][tag], ...languageUpdates};
}