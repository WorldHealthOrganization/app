import React from 'react';
import {
  IonContent,
  IonHeader,
  IonPage,
  IonTitle,
  IonToolbar,
} from '@ionic/react';
import * as Survey from 'survey-react';
import 'survey-react/survey.css';
import styles from './Triage.module.css';
import triage from '../surveys/triage.json';

interface TriageState {
  survey: Survey.ReactSurveyModel;
}

class Triage extends React.Component<{}, TriageState> {
  constructor(args: Readonly<{}>) {
    super(args);
    const survey = new Survey.ReactSurveyModel(triage);
    survey.onComplete.add(survey => console.log(survey.data));
    this.state = {
      survey,
    };
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
  }
}
export default Triage;
