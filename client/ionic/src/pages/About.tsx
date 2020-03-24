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

const About: React.FC = () => {
  const credits = useCredits();
  const licenseTexts = useLicenseTexts();
  return (
    <IonPage className="pa3">
      <TopNav />
      <IonContent>
        {credits &&
          licenseTexts &&
          licenseTexts.map((txt, i) => {
            const origText =
              'Built by the WHO COVID App Collective (see content/credits.yaml).';
            return (
              <view>
                {i === 0 && (
                  <p>
                    Built by the WHO COVID App Collective:{' '}
                    {credits.team.join(', ')}.
                  </p>
                )}
                <pre style={{ whiteSpace: 'pre-wrap', fontSize: '75%' }}>
                  {i === 0 ? txt.replace(origText, '') : txt}
                </pre>
              </view>
            );
          })}
      </IonContent>
    </IonPage>
  );
};

export default About;
