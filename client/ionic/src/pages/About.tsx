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

const About: React.FC = () => {
  return (
    <IonPage>
      <IonContent>
        <IonSlides pager={true}>
          <IonSlide>
            <IonCard>
              <IonCardContent>
                <IonImg src="assets/identity/who-logo-rgb.png" />
                <IonCardHeader>
                  <IonCardTitle>Official WHO App for COVID-19</IonCardTitle>
                  <IonCardSubtitle>
                    Learn how to protect yourself and your community.
                  </IonCardSubtitle>
                  <IonCardSubtitle>
                    Find medical resources to help.
                  </IonCardSubtitle>
                </IonCardHeader>
                <IonButton href="/menu" shape="round">
                  Learn More
                </IonButton>
              </IonCardContent>
            </IonCard>
          </IonSlide>
          <IonSlide>
            <IonCard>
              <IonCardHeader>
                <IonCardTitle>How it Spreads</IonCardTitle>
                <IonCardSubtitle>
                  COVID-19, also referred to as "Coronavirus", mainly spreads
                  from person-to-person between people who are in close contact
                  with one another (within about 6 feet or two meters) through
                  respiratory droplets produced when an infected person coughs
                  or sneezes.
                </IonCardSubtitle>
              </IonCardHeader>
              <IonCardContent>
                <IonIcon size="large" icon={personAddOutline}></IonIcon>
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
                <IonCardTitle>Clean Your Hands</IonCardTitle>
                <IonCardSubtitle>
                  <b>Wash your hands often</b> with soad and water for at least
                  20 sconds, especially after you have been in a public place,
                  or after blowing your nose, coughing or sneezing.
                </IonCardSubtitle>
                <IonCardSubtitle>
                  <b>Avoid touching your eyes, nose, and mouth</b> with unwashed
                  hands.
                </IonCardSubtitle>
              </IonCardHeader>
              <IonCardContent>
                <IonIcon size="large" icon={handLeftOutline}></IonIcon>
                <IonIcon size="large" icon={handRightOutline}></IonIcon>
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
                <IonCardTitle>Avoid Close Contact</IonCardTitle>
                <IonCardSubtitle>
                  <b>Avoid close contact</b> with people who are sick.
                </IonCardSubtitle>
                <IonCardSubtitle>
                  <b>Maintain distance between yourself and other people</b> if
                  COVID-19 is spreading in your community. This is especially
                  important for people who are at a higher risk of getting very
                  sick, including the elderly.
                </IonCardSubtitle>
              </IonCardHeader>
              <IonCardContent>
                <IonIcon size="large" icon={peopleOutline}></IonIcon>
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
