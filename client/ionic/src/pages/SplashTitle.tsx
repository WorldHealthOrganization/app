import React from 'react';
import {
  IonContent,
  IonPage,
  IonCard,
  IonText,
  IonCardContent,
  IonCardHeader,
  IonImg,
} from '@ionic/react';
import 'tachyons';

const SplashTitle: React.FC = () => {
  return (
    <IonPage className="pa3">
      <IonContent className="center tc th4 mt4">
        <IonCard button={true} routerLink="/splash-info">
          <IonCardHeader>
            <IonImg className="center" src="assets/identity/who-logo-rgb.png" />
          </IonCardHeader>
          <IonCardContent>
            <IonText color="primary" className="center mt4 pv4">
              <h2>The Official WHO COVID-19 Guide</h2>
            </IonText>
          </IonCardContent>
        </IonCard>
      </IonContent>
    </IonPage>
  );
};

export default SplashTitle;
