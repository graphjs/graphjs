import enUS from './en-US';
import frFR from './fr-FR';
import trTR from './tr-TR';

const languageData = {
    'en-US': enUS,
    'fr-FR': frFR,
    'tr-TR': trTR
};

// Language data
export default languageData;
// List of available languages
export const availableLanguages = Object.keys(languageData);