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
  IonImg,
} from '@ionic/react';
import 'tachyons';
import useDynamicFlow from '../hooks/useDynamicFlow';
import TopNav from '../components/TopNav';
import { TextImageScreen, LoadedFlow } from '../content/flow';

const TextImage = ( { screen, flow }: { screen: TextImageScreen, flow: LoadedFlow}) => {
  return (
    <IonSlide>
      <div className="flex flex-column h-100">
        <div>
          <IonCardTitle className="near-black">
            {screen.headingText}
          </IonCardTitle>
          <IonCardSubtitle></IonCardSubtitle>
        </div>
        <div className="tl">
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
        </div>
      </div>
    </IonSlide>
  );
}

const Carousel = ({ flow: flowName }: { flow: string }) => {
  // TODO: Refactor this out to separate Flow components. Use a dictionary
  // of screen archetypes.
  const flow = useDynamicFlow(flowName);
  return (
    <IonPage className="pa3">
      <TopNav />
      <IonContent className="center tc">
        {flow.content && flow.content.screens && (
          <IonSlides pager={true} className="h-auto">
            {flow.content.screens.map((screen, key) => {
              switch (screen.type) {
                case 'TextImage':
                  return <TextImage key={key} screen={screen} flow={flow} />;
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

export default Carousel;
