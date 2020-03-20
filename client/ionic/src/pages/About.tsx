import React from 'react';
import { IonContent, IonPage, IonSlides, IonSlide, IonCard, IonCardContent } from '@ionic/react';
import styles from './About.module.css';

const About: React.FC = () => {
  return (
    <IonPage className={styles.page}>
      <IonContent>
        <IonSlides pager={true}>
          <IonSlide>
            <IonCard>
              <IonCardContent>
               <p>Get the latest information</p>
              </IonCardContent>
            </IonCard>
          </IonSlide>
          <IonSlide>
            <IonCard>
              <IonCardContent>
               <p>Learn how to protect yourself</p>
              </IonCardContent>
            </IonCard>
          </IonSlide>
          <IonSlide>
            <IonCard>
              <IonCardContent>
               <p>Report sickness</p>
              </IonCardContent>
            </IonCard>
          </IonSlide>
        </IonSlides>
      </IonContent>
    </IonPage>
  );
};

export default About;
