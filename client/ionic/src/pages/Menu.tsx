import React from 'react';
import TopNav from '../components/TopNav';
import { IonContent, IonPage, IonItem, IonLabel } from '@ionic/react';
import 'tachyons';

const Menu: React.FC = () => {
  return (
    <IonPage className="pa3">
      <TopNav />
      <IonContent>
        <IonItem
          href="/protect-yourself"
          color="primary"
          className="pb3 tc ph4 pt2"
        >
          <IonLabel>Protect Yourself</IonLabel>
        </IonItem>
        <IonItem href="/triage" color="primary" className="pb3 tc ph4">
          <IonLabel>Check Your Health</IonLabel>
        </IonItem>
        <IonItem href="/menu-distress" color="primary" className="pb3 tc ph4">
          <IonLabel>Feeling Distressed?</IonLabel>
        </IonItem>
        <IonItem href="/local_maps" color="primary" className="pb3 tc ph4">
          <IonLabel>Local Maps</IonLabel>
        </IonItem>
        <IonItem href="/share" color="primary" className="pb3 tc ph4">
          <IonLabel>Share the App</IonLabel>
        </IonItem>
      </IonContent>
    </IonPage>
  );
};

export default Menu;
