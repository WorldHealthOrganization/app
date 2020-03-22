import React from 'react';
import {
  IonContent,
  IonPage,
  IonSlides,
  IonSlide,
  IonCard,
  IonCardContent,
  IonCardHeader,
  IonCardSubtitle,
  IonCardTitle,
  IonButton,
  IonImg,
} from '@ionic/react';
import 'tachyons';
import useDynamicFlow from '../hooks/useDynamicFlow';
import { S } from '../i18n/S';

// TODO: Rename to Splash, after other PRs to avoid conflicts.
const About: React.FC = () => {
  // TODO: Refactor this out to separate Flow components. Use a dictionary
  // of screen archetypes.
  const flow = useDynamicFlow('splash');
  return (
    <IonPage className="pa3">
      <IonContent className="center tc">
        <IonImg
          className="w-80 center"
          src="assets/identity/who-logo-rgb.png"
        />
        {flow.content && flow.content.screens && (
          <IonSlides pager={true} className="h-auto">
            {flow.content.screens.map((screen, key) => {
              switch (screen.type) {
                case 'TextImage':
                  return (
                    <IonSlide key={key}>
                      <IonCard>
                        <IonCardHeader>
                          <IonCardTitle className="near-black">
                            {screen.headingText}
                          </IonCardTitle>
                          <IonCardSubtitle></IonCardSubtitle>
                        </IonCardHeader>
                        <IonCardContent className="tl">
                          {screen.bodyTexts &&
                            screen.bodyTexts.map((txt, key) => (
                              <p key={key}>{txt}</p>
                            ))}
                          {screen.bottomImageUri && (
                            /* TODO: actual css */
                            <IonImg
                              className="center pt3 h4"
                              src={flow.imgPrefix + '/' + screen.bottomImageUri}
                            />
                          )}
                        </IonCardContent>
                        <IonCardContent>
                          <IonButton
                            className="center"
                            href="/menu"
                            shape="round"
                          >
                            {S.learnMore}
                          </IonButton>
                        </IonCardContent>
                      </IonCard>
                    </IonSlide>
                  );
                default:
                /** TODO: Handle errors of unsupported screen types correctly. */
              }
            })}
          </IonSlides>
        )}
        <IonButton className="pt2" href="/menu" shape="round">
          Learn More
        </IonButton>
      </IonContent>
    </IonPage>
  );
};

export default About;
