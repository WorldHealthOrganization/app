import React from 'react';
import TopNav from '../components/TopNav';
import { IonContent, IonPage, IonItem, IonLabel } from '@ionic/react';
import 'tachyons';

const MenuDistress: React.FC = () => {
  return (
    <IonPage className="pa3">
      <TopNav />
      <IonContent>
        <IonItem
          routerLink="/coping-everyone"
          color="primary"
          className="pb3 tc ph4 pt5"
        >
          <IonLabel>Information for Everyone</IonLabel>
        </IonItem>
        <IonItem
          routerLink="/coping-parents"
          color="primary"
          className="pb3 tc ph4"
        >
          <IonLabel>Information for Parents</IonLabel>
        </IonItem>
      </IonContent>
    </IonPage>
  );
};

export default MenuDistress;
