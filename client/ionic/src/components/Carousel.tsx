import React from 'react';
import {
  IonContent,
  IonPage,
  IonSlides,
  IonSlide,
  IonCardSubtitle,
  IonCardTitle,
  IonImg,
} from '@ionic/react';
import 'tachyons';
import useDynamicFlow from '../hooks/useDynamicFlow';
import TopNav from '../components/TopNav';
import { TextImageScreen, LoadedFlow } from '../content/flow';

const TextImage = ({
  screen,
  flow,
}: {
  screen: TextImageScreen;
  flow: LoadedFlow;
}) => {
  return (
    <IonSlide>
      <div className="flex flex-column justify-around h-100 pa4">
        <div className="mt3 tl" style={{ fontSize: '1.5em' }}>
          <IonCardTitle className="near-black">
            {screen.headingText}
          </IonCardTitle>
          <IonCardSubtitle></IonCardSubtitle>
          {screen.bodyTexts &&
            screen.bodyTexts.map((txt, key) => <p key={key}>{txt}</p>)}
        </div>
        <div>
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
};

const Carousel = ({ flow: flowName }: { flow: string }) => {
  const flow = useDynamicFlow(flowName);
  const slidesStyles = {
    '--bullet-background': 'var(--ion-color-primary-tint)',
    '--bullet-background-active': 'var(--ion-color-primary)',
  };
  return (
    <IonPage className="pa3">
      <TopNav />
      <IonContent className="center tc">
        {flow.content && flow.content.screens && (
          <IonSlides pager={true} className="h-100" style={slidesStyles}>
            {flow.content.screens.map((screen, key) => {
              switch (screen.type) {
                case 'TextImage':
                  return <TextImage key={key} screen={screen} flow={flow} />;
                default:
                  /** TODO: Handle errors of unsupported screen types correctly. */
                  return null;
              }
            })}
          </IonSlides>
        )}
      </IonContent>
    </IonPage>
  );
};

export default Carousel;
