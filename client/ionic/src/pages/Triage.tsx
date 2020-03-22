import React from 'react';
import { IonContent, IonPage } from '@ionic/react';
import TopNav from '../components/TopNav';
import * as Survey from 'survey-react';
import 'survey-react/survey.css';
import triage from '../surveys/triage.json';
import 'tachyons';

interface TriageState {
  survey: Survey.ReactSurveyModel;
}

class Triage extends React.Component<{}, TriageState> {
  constructor(args: Readonly<{}>) {
    super(args);
    const survey = new Survey.ReactSurveyModel(triage);

    // Update CSS classes
    survey.onUpdateQuestionCssClasses.add((survey, options) => {
      const classes = options.cssClasses;
      classes.mainRoot += ' f6';
      classes.root = 'sq-root';
      classes.title += '';
      classes.item += ' f4';
      classes.label += '';
      classes.header += ' f4';
      classes.body += ' f4';
    });
    //use this to do something with the survey data like an api call
    survey.onComplete.add(survey => console.log(survey.data));
    this.state = {
      survey,
    };
  }

  render() {
    return (
      <IonPage className="pa3">
        <TopNav />
        <IonContent>
          <Survey.Survey model={this.state.survey} />
        </IonContent>
      </IonPage>
    );
  }
}
export default Triage;
