import { createIntl, createIntlCache } from 'react-intl';
import messages_en from './en.json';
import messages_zh from './zh.json';

// tslint:disable-next-line:no-any
export const messages: any = {
  en: messages_en,
  zh: messages_zh,
};

export const language = navigator.language.split(/[-_]/)[0];
const cache = createIntlCache();
export const intl = createIntl(
  {
    locale: language,
    messages: messages[language],
  },
  cache
);
