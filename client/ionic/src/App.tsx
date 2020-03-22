import React from 'react';
import { Redirect, Route } from 'react-router-dom';
import { IonApp, IonRouterOutlet } from '@ionic/react';
import { IonReactRouter } from '@ionic/react-router';

import About from './pages/About';
import Menu from './pages/Menu';
import Triage from './pages/Triage';
import ProtectYourself from './pages/ProtectYourself';
import LocalMaps from './pages/LocalMaps';
import Distress from './pages/Distress';

/* Core CSS required for Ionic components to work properly */
import '@ionic/react/css/core.css';

/* Basic CSS for apps built with Ionic */
import '@ionic/react/css/normalize.css';
import '@ionic/react/css/structure.css';
import '@ionic/react/css/typography.css';

/* Optional CSS utils that can be commented out */
import '@ionic/react/css/padding.css';
import '@ionic/react/css/float-elements.css';
import '@ionic/react/css/text-alignment.css';
import '@ionic/react/css/text-transformation.css';
import '@ionic/react/css/flex-utils.css';
import '@ionic/react/css/display.css';

/* Theme variables */
import './theme/variables.css';

const App: React.FC = () => (
  <IonApp>
    <IonReactRouter>
      <IonRouterOutlet>
        <Route path="/about" component={About} exact={true} />
        <Route path="/menu" component={Menu} exact={true} />
        <Route
          path="/protect-yourself"
          component={ProtectYourself}
          exact={true}
        />
        <Route path="/triage" component={Triage} />
        <Route path="/distress" component={Distress} />
        <Route path="/" render={() => <Redirect to="/about" />} exact={true} />
        <Route path="/local-maps" component={LocalMaps} exact={true} />
      </IonRouterOutlet>
    </IonReactRouter>
  </IonApp>
);

export default App;
