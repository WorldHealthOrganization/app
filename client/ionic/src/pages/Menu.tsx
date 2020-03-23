import React from 'react';
import TopNav from '../components/TopNav';
import { IonButton, IonContent, IonPage } from '@ionic/react';
import 'tachyons';

const Menu: React.FC = () => {
  return (
    <IonPage className="pa3">
      <TopNav />
      <IonContent>
        <IonButton
          expand="block"
          routerLink="/protect-yourself"
          className="mb3 mh4 tc mt4"
        >
          Protect Yourself
        </IonButton>
        <IonButton
          expand="block"
          routerLink="/check-your-health"
          className="mb3 mh4 tc"
        >
          Check your Health
        </IonButton>
        <IonButton
          expand="block"
          fill="outline"
          routerLink="/about"
          className="mb3 mh4 tc"
        >
          Share the App
        </IonButton>
        <IonButton
          expand="block"
          fill="outline"
          routerLink="/about"
          className="mb3 mh4 tc"
        >
          Send Feedback
        </IonButton>
        <IonButton
          expand="block"
          fill="outline"
          routerLink="/about"
          className="mh4 tc"
        >
          About the App
        </IonButton>
      </IonContent>
    </IonPage>
  );
};

export default Menu;
