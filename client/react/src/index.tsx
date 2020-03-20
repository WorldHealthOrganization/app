import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './components/App';

import {createIntl, createIntlCache, IntlProvider} from "react-intl";
import messages_en from './i18n/en.json';
import messages_zh from './i18n/zh.json';

//const messages: Record<string, Record<string, any>> = {
const messages: any = {
  'en': messages_en,
  'zh': messages_zh,
};

let language = navigator.language.split(/[-_]/)[0];
const cache = createIntlCache();
export const intl = createIntl({
  locale: language,
  messages: messages[language]
}, cache);

ReactDOM.render(
  <IntlProvider locale={language} messages={messages[language]}>
    <App/>
  </IntlProvider>,
  document.getElementById('root'));

