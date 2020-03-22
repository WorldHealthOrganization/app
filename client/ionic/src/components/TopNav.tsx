import React from 'react';
import { IonHeader, IonItem, IonImg, IonToolbar } from '@ionic/react';
import { IonButtons, IonMenuButton, IonBackButton } from '@ionic/react';

const TopNav: React.FC = () => {
  return (
    <IonHeader className="ion-no-border">
      <IonToolbar>
        <IonItem lines="none" href="/menu">
          <IonImg
            className="left h3"
            src="assets/identity/who-logo-rgb.png"
          />
        </IonItem>
        <IonButtons slot="end">
          <IonBackButton defaultHref="/menu" icon="close"/>
        </IonButtons>
      </IonToolbar>
    </IonHeader>
  );
};

export default TopNav;
