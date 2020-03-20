import React from 'react';
import { IonContent, IonPage, IonHeader, IonTitle, IonToolbar, IonItem, IonLabel } from '@ionic/react';
import styles from './Tab1.module.css';

const Menu: React.FC = () => {
  return (
    <IonPage className={styles.page}>
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
