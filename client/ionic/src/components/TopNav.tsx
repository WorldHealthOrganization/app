import React from 'react';
import { IonHeader, IonItem, IonImg, IonToolbar } from '@ionic/react';
import { IonButtons, IonButton, IonIcon } from '@ionic/react';
import { close } from 'ionicons/icons';

// TODO: create a CSS style guide for when to use inline styles, etc.
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
          <IonImg
            className="h3 ml4"
            style={{ objectPosition: 'left' }}
            src="assets/identity/who-logo-rgb.png"
          />
        </IonButtons>
        <IonButtons
          slot="end"
          style={showClose ? {} : { visibility: 'hidden' }}
        >
          <IonButton {...linkProps}>
            <IonIcon
              slot="end"
              icon={close}
              color="primary"
              style={{ width: '2em', height: '2em' }}
            />
          </IonButton>
        </IonButtons>
      </IonToolbar>
    </IonHeader>
  );
};

TopNav.defaultProps = {
  showClose: true,
  linkify: true,
};

export default TopNav;
