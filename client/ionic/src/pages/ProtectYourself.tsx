import React from 'react';
import {
  IonContent,
  IonHeader,
  IonItem,
  IonPage,
  IonToolbar,
  IonSlides,
  IonSlide,
  IonCard,
  IonCardContent,
  IonImg
} from '@ionic/react';
import 'tachyons';

const ProtectYourself: React.FC = () => {
  return (

    <IonPage className="pa3">
      <IonHeader>
        <IonToolbar>
          <IonItem href="/menu">
            <IonImg
              className="w-80 center h3"
              src="assets/identity/who-logo-rgb.png"
            />
          </IonItem>
        </IonToolbar>
      </IonHeader>
      <IonContent>
        <IonSlides pager={true}>
          <IonSlide>
            <IonCard>
              <IonCardContent className="pb3 tc ph5">
                <b>Wash your hands</b> often with soap and running water frequently
              </IonCardContent>
            </IonCard>
          </IonSlide>
          <IonSlide>
            <IonCard>
              <IonCardContent>
                <b>When coughing and squeezing cover mouth and nose</b> with flexed elbow or tissue
              </IonCardContent>
            </IonCard>
          </IonSlide>
          <IonSlide>
            <IonCard>
              <IonCardContent>
                Throw tissue into <b>closed bin</b> immediately after use
              </IonCardContent>
            </IonCard> 
          </IonSlide>
          <IonSlide>
            <IonCard>
              <IonCardContent>
                Wash your hands <b>frequently</b>
              </IonCardContent>
            </IonCard> 
          </IonSlide>
          <IonSlide>
            <IonCard>
              <IonCardContent>
                <b>Avoid close contact</b> and keep the physical distancing                
              </IonCardContent>
            </IonCard>
          </IonSlide>
          <IonSlide>
            <IonCard>
              <IonCardContent>
                <b>Seek medical care early</b> if you have fever, cough, and difficulty breathing
              </IonCardContent>
            </IonCard>
          </IonSlide>
        </IonSlides>
      </IonContent>
    </IonPage>
  );
};

export default ProtectYourself;
