import React from 'react';
import { IonContent, IonPage, IonHeader, IonTitle, IonToolbar, IonItem, IonLabel } from '@ionic/react';

const Menu: React.FC = () => {
  return (
    <IonPage>
      <IonHeader>
        <IonToolbar>
          <IonTitle>
            <IonItem href="/Menu" color="primary">WHO</IonItem>
          </IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonContent>
        <IonItem href="/ProtectYourself">
          <IonLabel>Protect Yourself</IonLabel>
        </IonItem>
        <IonItem href="/Triage">
          <IonLabel>Check Your Health</IonLabel>
        </IonItem>
        <IonItem href="/LocalMaps">
          <IonLabel>Local Maps</IonLabel>
        </IonItem>
        <IonItem href="/Share">
          <IonLabel>Share the App</IonLabel>
        </IonItem>
      </IonContent>
    </IonPage>
  );
};

export default Menu;
