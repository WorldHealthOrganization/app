import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';
import * as serviceWorker from './serviceWorker';

import {createIntl, createIntlCache, IntlProvider} from "react-intl";
import messages_en from './i18n/en.json';
import messages_zh from './i18n/zh.json';

// tslint:disable-next-line:no-any
const messages: any = {
  'en': messages_en,
  'zh': messages_zh,
};

const language = navigator.language.split(/[-_]/)[0];
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


// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
