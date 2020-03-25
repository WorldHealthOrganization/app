import React from 'react';
import { IonPage, IonContent } from '@ionic/react';
import TopNav from '../components/TopNav';
import * as yaml from 'js-yaml';

import { useEffect, useState } from 'react';

interface Credits {
  team: string[];
  supporters: string[];
}

function useCredits() {
  const [credits, setCredits] = useState(null as Credits | null);

  useEffect(() => {
    async function fetchCredits() {
      const url = `${process.env.PUBLIC_URL}/assets/content/credits.yaml`;
      const respText = await fetch(url).then(e => e.text());
      setCredits(yaml.safeLoad(respText) as Credits);
    }
    fetchCredits();
  }, []);

  return credits;
}

function useLicenseTexts() {
  const [licenses, setLicenses] = useState(null as string[] | null);

  useEffect(() => {
    async function fetchCredits() {
      // Our LICENSE is always first.
      // It is a .txt file so it gets included and served.
      const licenseFiles = ['LICENSE.txt', 'THIRD_PARTY_LICENSE.txt'];
      const urls = licenseFiles.map(
        f => `${process.env.PUBLIC_URL}/assets/${f}`
      );
      const respTexts = await Promise.all(
        urls.map(u => fetch(u).then(e => e.text()))
      );
      setLicenses(respTexts);
    }
    fetchCredits();
  }, []);

  return licenses;
}

// TODO: DRY with above, functional per content type / relative path
// TODO: INTL

function usePrivacyPolicy() {
  const [privacyPolicy, setPrivacyPolicy] = useState(null as string | null);

  useEffect(() => {
    async function fetchPrivacyPolicy() {
      const url = `${process.env.PUBLIC_URL}/assets/content/privacy-policy.txt`;
      const respText = await fetch(url).then(e => e.text());
      setPrivacyPolicy(respText);
    }
    fetchPrivacyPolicy();
  }, []);

  return privacyPolicy;
}

function useTermsOfService() {
  const [termsOfService, setTermsOfService] = useState(null as string | null);

  useEffect(() => {
    async function fetchTermsOfService() {
      const url = `${process.env.PUBLIC_URL}/assets/content/terms-of-service.txt`;
      const respText = await fetch(url).then(e => e.text());
      setTermsOfService(respText);
    }
    fetchTermsOfService();
  }, []);

  return termsOfService;
}

const About: React.FC = () => {
  const credits = useCredits();
  const licenseTexts = useLicenseTexts();
  const privacyPolicy = usePrivacyPolicy();
  const termsOfService = useTermsOfService();

  // TODO: Dynamic App / build versions updated by CI/CD

  return (
    <IonPage className="pa3">
      <TopNav />
      <IonContent>
        <p>
          This is the official COVID-19 app by WHO (World Health Organization).
        </p>
        <p>
          Help fight Coronavirus by going to{' '}
          <a
            href="https://covid19responsefund.org"
            target="_blank"
            rel="noopener noreferrer"
          >
            https://covid19responsefund.org
          </a>
        </p>
        <b>Terms of Service</b>
        <pre style={{ whiteSpace: 'pre-wrap', fontSize: '75%' }}>
          {termsOfService}
        </pre>
        <b>Privacy Policy</b>
        <pre style={{ whiteSpace: 'pre-wrap', fontSize: '75%' }}>
          {privacyPolicy}
        </pre>
        <b>Credits</b>
        <p>
          Built by the WHO COVID App Collective:{' '}
          {credits && credits.team.join(', ')}.
        </p>
        <b>Licenses</b>
        {licenseTexts &&
          licenseTexts.map((txt, i) => {
            const origText =
              'Built by the WHO COVID App Collective (see content/credits.yaml).';
            return (
              <view>
                <pre style={{ whiteSpace: 'pre-wrap', fontSize: '75%' }}>
                  {i === 0 ? txt.replace(origText, '') : txt}
                </pre>
              </view>
            );
          })}
        <p>App version 0.1</p>
      </IonContent>
    </IonPage>
  );
};

export default About;
