import React from 'react';
import { IonHeader, IonItem, IonImg, IonToolbar } from '@ionic/react';
import { IonButtons, IonButton, IonIcon } from '@ionic/react';
import { close } from 'ionicons/icons';

const TopNav = ({
  showClose,
  linkify,
}: {
  showClose?: boolean;
  linkify?: boolean;
}) => {
  const linkProps = linkify ? { routerLink: '/menu' } : {};
  return (
    <IonHeader className="ion-no-border">
      <IonToolbar>
        <IonButtons slot="start">
          <IonItem slot="start" lines="none" {...linkProps}>
            <IonImg
              className="left h3"
              src="assets/identity/who-logo-rgb.png"
            />
          </IonItem>
        </IonButtons>
        {showClose && (
          <IonButtons slot="end">
            <IonButton {...linkProps}>
              <IonIcon slot="end" icon={close} />
            </IonButton>
          </IonButtons>
        )}
      </IonToolbar>
    </IonHeader>
  );
};

TopNav.defaultProps = {
  showClose: true,
  linkify: true,
};

export default TopNav;
