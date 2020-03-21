import React from 'react';
import { FlowLoader, Flow, LoadedFlow } from '../content/flow';
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
import { getUserContext } from '../content/userContext';

function useDynamicFlow(id: string) {
  const [flow, setFlow] = React.useState({} as LoadedFlow);

  React.useEffect(() => {
    async function fetchFlow() {
      const f = await FlowLoader.loadFlow(id, getUserContext());
      setFlow(f);
    }
    fetchFlow();
  }, [id]);

  return flow;
}

// TODO: Rename to Splash, after other PRs to avoid conflicts.
const About: React.FC = () => {
  // TODO: Refactor this out to separate Flow components. Use a dictionary
  // of screen archetypes.
  const flow = useDynamicFlow('protect');
  return (
    <IonPage className="pa3">
      <IonContent>
        <IonImg
          className="w-80 center"
          src="assets/identity/who-logo-rgb.png"
        />
        {flow.content && flow.content.screens && (
          <IonSlides pager={true}>
            {flow.content.screens.map(screen => {
              switch (screen.type) {
                case 'TextImage':
                  return (
                    <IonSlide>
                      <IonCard>
                        <IonCardHeader>
                          <IonCardTitle className="near-black">
                            {screen.headingText}
                          </IonCardTitle>
                          <IonCardSubtitle></IonCardSubtitle>
                        </IonCardHeader>
                        <IonCardContent className="tl">
                          {screen.bodyTexts &&
                            screen.bodyTexts.map(txt => <p>{txt}</p>)}
                          {screen.bottomImageUri && (
                            /* TODO: actual css */
                            <IonImg
                              className="center"
                              style={{
                                width: 100,
                              }}
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
                            Learn More
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
      </IonContent>
    </IonPage>
  );
};

export default About;
