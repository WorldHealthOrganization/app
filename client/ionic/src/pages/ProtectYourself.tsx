import React from 'react';
import {
  IonContent,
  IonHeader,
  IonPage,
  IonTitle,
  IonToolbar,
  IonItem,
} from '@ionic/react';

const ProtectYourself: React.FC = () => {
  return (
    <IonPage>
      <IonHeader>
        <IonToolbar>
          <IonItem href="/menu" color="primary">
            WHO
          </IonItem>
        </IonToolbar>
      </IonHeader>
    </IonPage>
  );
};
export default ProtectYourself;
