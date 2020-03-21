import React from 'react';
import { render } from '@testing-library/react';
import App from './App';
import { IntlProvider } from 'react-intl';
import { language, messages } from './i18n/i18n';

test('renders without crashing', () => {
  const { baseElement } = render(
    <IntlProvider locale={language} messages={messages[language]}>
      <App />
    </IntlProvider>
  );
  expect(baseElement).toBeDefined();
});
