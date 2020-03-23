import React from 'react';
import { IonContent, IonPage, IonText, IonImg, IonCard } from '@ionic/react';
import 'tachyons';

const SplashTitle: React.FC = () => {
  return (
    <IonPage className="pa4">
      <IonContent style={{ '--overflow': 'hidden' }}>
        <IonCard
          routerLink="/splash-info"
          className="center tc h-100 flex flex-row items-center"
        >
          <div className="flex flex-column" style={{ marginBottom: 100 }}>
            <div>
              <IonImg
                className="center"
                src="assets/identity/who-logo-rgb.png"
              />
            </div>
            <div className="">
              <IonText color="primary" className="center mt4 pv4">
                <h2>The Official WHO COVID-19 Guide</h2>
              </IonText>
            </div>
          </div>
        </IonCard>
      </IonContent>
    </IonPage>
  );
};

export default SplashTitle;
