import React from 'react';
import {
  IonContent,
  IonPage,
  IonItem,
  IonCard,
  IonCardContent,
  IonCardHeader,
  IonImg,
  IonList,
  IonIcon,
  IonLabel,
} from '@ionic/react';

import 'tachyons';
import { square } from 'ionicons/icons';

const SplashInfo: React.FC = () => {
  return (
    <IonPage className="pa3">
      <IonContent className="center tc th4 mt4">
        <IonCard button={true} routerLink="/splash-carousel">
          <IonCardHeader>
            <IonImg className="center" src="assets/identity/who-logo-rgb.png" />
          </IonCardHeader>
          <IonCardContent>
            <IonList lines="none" className="pt4">
              <IonItem>
                <IonLabel color="primary">Get the latest information</IonLabel>
                <IonIcon
                  icon={square}
                  size="large"
                  slot="start"
                  color="primary"
                />
              </IonItem>
              <IonItem>
                <IonLabel color="primary">
                  Learn how to protect yourself
                </IonLabel>
                <IonIcon
                  icon={square}
                  size="large"
                  slot="start"
                  color="primary"
                />
              </IonItem>
              <IonItem>
                <IonLabel color="primary">Report Sickness</IonLabel>
                <IonIcon
                  icon={square}
                  size="large"
                  slot="start"
                  color="primary"
                />
              </IonItem>
            </IonList>
          </IonCardContent>
        </IonCard>
      </IonContent>
    </IonPage>
  );
};

export default SplashInfo;
