import React from 'react';
import { IonHeader, IonItem, IonImg, IonToolbar } from '@ionic/react';
import { IonButtons, IonButton, IonIcon } from '@ionic/react';
import { close } from 'ionicons/icons';

const TopNav: React.FC = () => {
  return (
    <IonHeader className="ion-no-border">
      <IonToolbar>
        <IonItem lines="none" routerLink="/menu">
          <IonImg className="left h3" src="assets/identity/who-logo-rgb.png" />
        </IonItem>
        <IonButtons slot="end">
          <IonButton routerLink="/menu">
            <IonIcon slot="end" icon={close} />
          </IonButton>
        </IonButtons>
      </IonToolbar>
    </IonHeader>
  );
};

export default TopNav;
