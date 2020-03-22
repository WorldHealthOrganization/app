import React from 'react';
import { IonItem, IonPage, IonLabel, IonImg } from '@ionic/react';

export const GettingStarted: React.FC = () => {
  return (
    <IonPage className="gs">
      <IonImg
        style={style.image}
        className="center"
        src="assets/identity/who-logo-rgb.png"
      />
      <IonItem style={style.labelContainer}>
        <IonLabel style={style.label}>The official COVID-19 GUIDE</IonLabel>
      </IonItem>
    </IonPage>
  );
};

const style = {
  label: {
    color: '#008DC9',
    fontSize: 24,
    fontWeight: 550,
    lineHeight: 28,
    fontFamily: 'National',
  },
  image: {
    width: 277,
    height: 152,
    left: 43,
    top: 150,
  },
  labelContainer: {
    textAlign: 'center',
  },
};
