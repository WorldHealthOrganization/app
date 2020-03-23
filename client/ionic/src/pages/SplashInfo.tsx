import React, { ReactNode } from 'react';
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

const ListItem = ({ children }: { children: ReactNode }) => (
  <IonItem style={{ maxHeight: 35 }}>
    <IonLabel color="primary" style={{ fontWeight: 'bold' }}>
      {children}
    </IonLabel>
    <IonIcon
      icon={square}
      size="small"
      slot="start"
      color="primary"
      style={{ marginRight: 20, marginTop: 0, marginBottom: 0 }}
    />
  </IonItem>
);

const SplashInfo: React.FC = () => {
  return (
    <IonPage className="pa4">
      <IonContent style={{ '--overflow': 'hidden' }}>
        <IonCard
          routerLink="/splash-carousel"
          className="center tc h-100 flex flex-row items-center"
        >
          <IonCardHeader>
            <IonImg
              className="center"
              style={{ maxWidth: 100 }}
              src="assets/identity/who-logo-only.png"
            />
          </IonCardHeader>
          <IonCardContent>
            <IonList lines="none" className="pt4">
              <ListItem>Get the latest information</ListItem>
              <ListItem>Learn how to protect yourself</ListItem>
              <ListItem>Report sickness</ListItem>
            </IonList>
          </IonCardContent>
        </IonCard>
      </IonContent>
    </IonPage>
  );
};

export default SplashInfo;
