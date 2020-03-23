import React from 'react';
import {
  IonContent,
  IonPage,
  IonSlides,
  IonSlide,
  IonItem,
  IonCard,
  IonText,
  IonCardContent,
  IonCardHeader,
  IonCardSubtitle,
  IonCardTitle,
  IonButton,
  IonImg,
  IonList
} from '@ionic/react';
import 'tachyons';
import 'square' from '@ionicons';

const SplashInfo: React.FC = () => {
  return (
    <IonPage className="pa3">
      <IonContent className="center tc th4 mt4">
        <IonCard button={true} routerLink="/splash-info">
          <IonCardHeader>
            <IonImg
              className="center"
              src="assets/identity/who-logo-rgb.png"
            />
          </IonCardHeader>
          <IonCardContent>
            <IonList lines="none">
               <IonItem>Item 1
          <IonLabel>
            Large Icon End
      </IonLabel>
          <IonIcon icon={square} size="large" slot="end" />
</IonItem>
               <IonItem>Item 2</IonItem>
               <IonItem>Item 3</IonItem>
            </IonList>
          </IonCardContent>
        </IonCard>
      </IonContent>
    </IonPage>
  );
};

export default SplashInfo;
