import React from 'react';
import {
  IonContent,
  IonPage,
  IonSlides,
  IonSlide,
  IonCard,
  IonCardContent,
  IonImg,
} from '@ionic/react';
import TopNav from '../components/TopNav';
import 'tachyons';
import useDynamicFlow from '../hooks/useDynamicFlow';

const CheckYourHealth: React.FC = () => {
  // TODO: Refactor this out to separate Flow components. Use a dictionary
  // of screen archetypes.
  const flow = useDynamicFlow('check-your-health');
  return (
    <IonPage className="pa3">
      <TopNav />
      <IonContent>
        {flow.content && flow.content.screens && (
          <IonSlides pager={true}>
            {flow.content.screens.map(screen => {
              switch (screen.type) {
                case 'TextImage':
                  return (
                    <IonSlide>
                      <IonCard>
                        <IonCardContent className="pb3 tl ph5">
                          {screen.bottomImageUri && (
                            /* TODO: actual css */
                            <IonImg
                              className="h4 center pb3"
                              src={flow.imgPrefix + '/' + screen.bottomImageUri}
                            />
                          )}
                          {screen.bodyTexts &&
                            screen.bodyTexts.map(txt => <p>{txt}</p>)}
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
      </IonContent>
    </IonPage>
  );
};

export default CheckYourHealth;
