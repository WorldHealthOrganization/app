import React from 'react';
import {
  IonContent,
  IonHeader,
  IonPage,
  IonTitle,
  IonToolbar,
  IonItem,
} from '@ionic/react';

class Protect_Yourself extends React.Component<{}> {
  constructor(args: Readonly<{}>) {
  super(args);
  this.state = {}
}

  render() {
    return (
      <IonPage>
      <IonHeader>
          <IonToolbar>
            <IonItem href="/menu" color="primary">
            WHO
            </IonItem>
          </IonToolbar>
        </IonHeader>
      </IonPage>
    );
  }
}

export default Protect_Yourself;