import React from 'react';
import { IonPage } from '@ionic/react';
import TopNav from '../components/TopNav';

const About: React.FC = () => {
  return (
    <IonPage className="pa3">
      <TopNav />
    </IonPage>
  );
};

export default About;
