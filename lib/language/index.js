import enUS from './en-US';
import frFR from './fr-FR';

const languageData = {
    'en-US': enUS,
    'fr-FR': frFR
};

// Language data
export default languageData;
// List of available languages
export const availableLanguages = Object.keys(languageData);