import React from 'react';
import {
  IonContent,
  IonHeader,
  IonPage,
  IonTitle,
  IonToolbar,
} from '@ionic/react';
import ExploreContainer from '../components/ExploreContainer';
import styles from './Tab2.module.css';

const Tab2: React.FC = () => {
  return (
    <IonPage className={styles.page}>
      <IonHeader>
        <IonToolbar>
          <IonTitle>Camera</IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonContent>
        <IonHeader collapse="condense">
          <IonToolbar>
            <IonTitle size="large">Camera</IonTitle>
          </IonToolbar>
        </IonHeader>
        <ExploreContainer name="Camera name" />
      </IonContent>
    </IonPage>
  );
};

export default Tab2;
