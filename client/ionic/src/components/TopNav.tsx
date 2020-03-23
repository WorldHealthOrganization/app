import React from 'react';
import { IonHeader, IonItem, IonImg, IonToolbar } from '@ionic/react';

const TopNav: React.FC = () => {
  return (
    <IonHeader className="ion-no-border">
      <IonToolbar>
        <IonItem lines="none" href="/menu">
          <IonImg
            className="w-80 center h3"
            src="assets/identity/who-logo-rgb.png"
          />
        </IonItem>
      </IonToolbar>
    </IonHeader>
  );
};

export default TopNav;
