import React from 'react';
import { IonContent, IonHeader, IonPage, IonTitle, IonToolbar } from '@ionic/react';
import ExploreContainer from '../components/ExploreContainer';
import ShareButton from '../components/ShareButton';
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
        <ShareButton shareStr="Checkout the new WHO App"/>
        <ExploreContainer name="Tab 1 page" />
      </IonContent>
    </IonPage>
  );
};

export default Tab1;
