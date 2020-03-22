import React from 'react';
import { FlowLoader, Flow, LoadedFlow } from '../content/flow';
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
import { getUserContext } from '../content/userContext';

// TODO: Abstract this, DRY.

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

const CopingParents: React.FC = () => {
  // TODO: Refactor this out to separate Flow components. Use a dictionary
  // of screen archetypes.
  const flow = useDynamicFlow('copingParents');
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
                        <IonCardContent className="pb3 tc ph5">
                          {screen.bottomImageUri && (
                            /* TODO: actual css */
                            <IonImg
                              className="w-80 center"
                              style={{
                                width: 260,
                              }}
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

export default CopingParents;
