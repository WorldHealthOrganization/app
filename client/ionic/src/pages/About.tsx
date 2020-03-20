import React from 'react';
import { IonContent, IonPage, IonSlides, IonSlide } from '@ionic/react';
import styles from './About.module.css';

const About: React.FC = () => {
  return (
    <IonPage className={styles.page}>
      <IonContent>
        <IonSlides pager={true}>
          <IonSlide>
           <p>Get the latest information</p>
          </IonSlide>
          <IonSlide>
           <p>Learn how to protect yourself</p>
          </IonSlide>
          <IonSlide>
           <p>Report sickness</p>
          </IonSlide>
        </IonSlides>
      </IonContent>
    </IonPage>
  );
};

export default About;
