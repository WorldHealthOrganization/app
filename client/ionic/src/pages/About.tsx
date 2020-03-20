import React from 'react';
import { IonContent, IonPage, IonList, IonItem, IonLabel } from '@ionic/react';
import styles from './About.module.css';

const About: React.FC = () => {
  return (
    <IonPage className={styles.page}>
      <IonContent>
        <IonList>
          <IonItem>
            <IonLabel>Get the latest information</IonLabel>
          </IonItem>
          <IonItem>
            <IonLabel>Learn how to protect yourself</IonLabel>
          </IonItem>
          <IonItem>
            <IonLabel>Report sickness</IonLabel>
          </IonItem>
        </IonList>
      </IonContent>
    </IonPage>
  );
};

export default About;
