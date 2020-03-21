import React from 'react';
import {
  IonContent,
  IonPage,
  IonHeader,
  IonTitle,
  IonToolbar,
  IonItem,
  IonLabel,
} from '@ionic/react';
import {shareMessage} from '../components/ShareButton';
const Menu: React.FC = () => {
  return (
    <IonPage>
      <IonHeader>
        <IonToolbar>
          <IonTitle>
            <IonItem href="/menu" color="primary">
              WHO
            </IonItem>
          </IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonContent>
        <IonItem href="/protect_yourself">
          <IonLabel>Protect Yourself</IonLabel>
        </IonItem>
        <IonItem href="/triage">
          <IonLabel>Check Your Health</IonLabel>
        </IonItem>
        <IonItem href="/local_maps">
          <IonLabel>Local Maps</IonLabel>
        </IonItem>
        <IonItem onClick={()=>shareMessage("Check the WHO App out")}>
          <IonLabel>Share the App</IonLabel>
        </IonItem>
      </IonContent>
    </IonPage>
  );
};

export default Menu;
