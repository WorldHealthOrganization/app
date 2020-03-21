import React from 'react';
import {
  IonContent,
  IonPage,
  IonSlides,
  IonSlide,
  IonCard,
  IonCardContent,
  IonCardHeader,
  IonCardSubtitle,
  IonCardTitle,
  IonButton,
  IonImg,
  IonIcon,
} from '@ionic/react';
import {
  personAddOutline,
  handRightOutline,
  handLeftOutline,
  peopleOutline,
} from 'ionicons/icons';
import 'tachyons';

const About: React.FC = () => {
  return (
    <IonPage className="pa3">
      <IonContent>
        <IonImg
          className="w-80 center"
          src="assets/identity/who-logo-rgb.png"
        />
        <IonSlides pager={true}>
          <IonSlide>
            <IonCard className="h-100">
              <IonCardContent>
                <IonCardHeader>
                  <IonCardTitle className="near-black">
                    Official WHO App for COVID-19
                  </IonCardTitle>
                </IonCardHeader>
                <IonCardContent className="tl">
                  Learn how to protect yourself and your community. Find medical
                  resources to help.
                </IonCardContent>
                <IonButton href="/menu" shape="round">
                  Learn More
                </IonButton>
              </IonCardContent>
            </IonCard>
          </IonSlide>
          <IonSlide>
            <IonCard>
              <IonCardHeader>
                <IonCardTitle className="near-black">
                  How it Spreads
                </IonCardTitle>
                <IonCardSubtitle></IonCardSubtitle>
              </IonCardHeader>
              <IonIcon size="large" icon={personAddOutline}></IonIcon>
              <IonCardContent className="tl">
                COVID-19, also referred to as "Coronavirus", mainly spreads from
                person-to-person between people who are in close contact with
                one another (within about 6 feet or two meters) through
                respiratory droplets produced when an infected person coughs or
                sneezes.
              </IonCardContent>
              <IonCardContent>
                <IonButton href="/menu" shape="round">
                  Learn More
                </IonButton>
              </IonCardContent>
            </IonCard>
          </IonSlide>
          <IonSlide>
            <IonCard>
              <IonCardHeader>
                <IonCardTitle className="near-black">
                  Clean Your Hands
                </IonCardTitle>
                <IonCardSubtitle></IonCardSubtitle>
              </IonCardHeader>
              <IonCardSubtitle></IonCardSubtitle>
              <IonIcon size="large" icon={handLeftOutline}></IonIcon>
              <IonIcon size="large" icon={handRightOutline}></IonIcon>
              <IonCardContent>
                <b>Wash your hands often</b> with soap and water for at least 20
                seconds, especially after you have been in a public place, or
                after blowing your nose, coughing or sneezing.
                <b>Avoid touching your eyes, nose, and mouth</b> with unwashed
                hands.
              </IonCardContent>
              <IonCardContent>
                <IonButton href="/menu" shape="round">
                  Learn More
                </IonButton>
              </IonCardContent>
            </IonCard>
          </IonSlide>
          <IonSlide>
            <IonCard>
              <IonCardHeader>
                <IonCardTitle className="near-black">
                  Avoid Close Contact
                </IonCardTitle>
                <IonCardSubtitle></IonCardSubtitle>
              </IonCardHeader>
              <IonIcon size="large" icon={peopleOutline}></IonIcon>
              <IonCardContent>
                <b>Avoid close contact</b> with people who are sick.
              </IonCardContent>
              <IonCardContent>
                <b>Maintain distance between yourself and other people</b> if
                COVID-19 is spreading in your community. This is especially
                important for people who are at a higher risk of getting very
                sick, including the elderly.
              </IonCardContent>
              <IonCardContent>
                <IonButton href="/menu" shape="round">
                  Learn More
                </IonButton>
              </IonCardContent>
            </IonCard>
          </IonSlide>
        </IonSlides>
      </IonContent>
    </IonPage>
  );
};

export default About;
