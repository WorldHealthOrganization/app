import React from 'react';
import { IonContent, IonPage, IonItem, IonLabel, IonImg } from '@ionic/react';
import 'tachyons';

const Menu: React.FC = () => {
  return (
    <IonPage className="pa3">
      <IonContent>
        <IonImg
          className="w-80 center pb5"
          src="assets/identity/who-logo-rgb.png"
        />
        <IonItem
          href="/protect_yourself"
          color="primary"
          className="pb3 tc ph5"
        >
          <IonLabel>Protect Yourself</IonLabel>
        </IonItem>
        <IonItem href="/triage" color="primary" className="pb3 tc ph5">
          <IonLabel>Check Your Health</IonLabel>
        </IonItem>
        <IonItem href="/distress" color="primary" className="pb3 tc ph5">
          <IonLabel>Feeling Distressed?</IonLabel>
        </IonItem>
        <IonItem href="/local_maps" color="primary" className="pb3 tc ph5">
          <IonLabel>Local Maps</IonLabel>
        </IonItem>
        <IonItem href="/share" color="primary" className="pb3 tc ph5">
          <IonLabel>Share the App</IonLabel>
        </IonItem>
      </IonContent>
    </IonPage>
  );
};

export default Menu;
