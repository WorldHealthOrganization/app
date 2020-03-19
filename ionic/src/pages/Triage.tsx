import React from 'react';
import { IonContent, IonHeader, IonPage, IonTitle, IonToolbar } from '@ionic/react';
import * as Survey from "surveyjs-react";
import "surveyjs-react/survey.css";
import styles from './Triage.module.css';
import triage from '../surveys/triage.json';

type TriageState = {
    survey: Survey.ReactSurveyModel
}

class Triage extends React.Component<{}, TriageState> {
    constructor() {
        super({});
        this.state = {
            survey: new Survey.ReactSurveyModel(triage)
        }
    }
    render() {
  return (
    <IonPage className={styles.page}>
      <IonHeader>
        <IonToolbar>
          <IonTitle>Tab 3</IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonContent>
        <IonHeader collapse="condense">
          <IonToolbar>
            <IonTitle size="large">Tab 3</IonTitle>
          </IonToolbar>
        </IonHeader>
        <Survey.Survey model={this.state.survey} />
      </IonContent>
    </IonPage>
  );
};
}
export default Triage;
