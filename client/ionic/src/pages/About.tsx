import React from 'react';
import { IonContent, IonPage } from '@ionic/react';
import styles from './About.module.css';

const About: React.FC = () => {
  return (
    <IonPage className={styles.page}>
      <IonContent>
        <div className="container">
          <ul>
            <li>Get the latest information</li>
            <li>Learn how to protect yourself</li>
            <li>Report sickness</li>
          </ul>
        </div>
      </IonContent>
    </IonPage>
  );
};

export default About;
