import React from 'react';
import { IonContent, IonPage, IonSlides, IonSlide, IonImg } from '@ionic/react';
import 'tachyons';
import useDynamicFlow from '../hooks/useDynamicFlow';
import TopNav from '../components/TopNav';
import { TextEmojiScreen, TextImageScreen, LoadedFlow } from '../content/flow';
import RenderHTML from './RenderHTML';

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
        <div className="mt3 tl">
          {screen.headingText && (
            <div style={{ fontSize: '1.5em' }}>{screen.headingText}</div>
          )}
          <div style={{ fontSize: screen.headingText ? '1em' : '1.5em' }}>
            {screen.bodyTexts &&
              screen.bodyTexts.map((txt, key) => (
                <RenderHTML source={txt} key={key} />
              ))}
          </div>
        </div>
        <div>
          {screen.bottomImageUri && (
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

const TextEmoji = ({ screen }: { screen: TextEmojiScreen }) => {
  return (
    <IonSlide>
      <div className="flex flex-column justify-around h-100 pa4">
        <div className="mt3 tl">
          {screen.bodyTexts && (
            <div style={{ fontSize: '1.2em', textAlign: 'center' }}>
              {screen.bodyTexts.map((txt, key) => (
                <RenderHTML source={txt} key={key} />
              ))}
            </div>
          )}
        </div>
        <div>
          {screen.bottomEmoji && (
            <p style={{ fontSize: '6em' }}>{screen.bottomEmoji}</p>
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
                case 'TextEmoji':
                  return <TextEmoji key={key} screen={screen} />;
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
