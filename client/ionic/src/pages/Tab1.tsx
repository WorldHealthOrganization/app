import React from 'react';
import { IonContent, IonHeader, IonPage, IonTitle, IonToolbar } from '@ionic/react';
import ExploreContainer from '../components/ExploreContainer';
import styles from './Tab1.module.css';

const Tab1: React.FC = () => {
  return (
    <IonPage className={styles.page}>
      <IonHeader>
        <IonToolbar>
          <IonTitle>Tab Abcd</IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonContent>
        <IonHeader collapse="condense">
          <IonToolbar>
            <IonTitle size="large">Tab 1</IonTitle>
          </IonToolbar>
        </IonHeader>
<<<<<<< HEAD
        <ShareButton shareStr="Checkout the new WHO App"/>
=======
>>>>>>> parent of 591ea71... Share button
        <ExploreContainer name="Tab 1 page" />
      </IonContent>
    </IonPage>
  );
};

export default Tab1;
