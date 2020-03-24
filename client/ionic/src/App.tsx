import React from 'react';
import { Redirect, Route } from 'react-router-dom';
import { IonApp, IonRouterOutlet } from '@ionic/react';
import { IonReactRouter } from '@ionic/react-router';

import About from './pages/About';
import SplashTitle from './pages/SplashTitle';
import SplashInfo from './pages/SplashInfo';
import SplashCarousel from './pages/SplashCarousel';
import Menu from './pages/Menu';
import ProtectYourself from './pages/ProtectYourself';
import WhoMythbusters from './pages/WhoMythbusters';
import TravelAdvice from './pages/TravelAdvice';

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

/* Global styling */
import './global.css';

const App: React.FC = () => (
  <IonApp>
    <IonReactRouter>
      <IonRouterOutlet>
        <Route path="/about" component={About} exact={true} />
        <Route path="/splash-title" component={SplashTitle} exact={true} />
        <Route path="/splash-info" component={SplashInfo} exact={true} />
        <Route
          path="/splash-carousel"
          component={SplashCarousel}
          exact={true}
        />
        <Route path="/menu" component={Menu} exact={true} />
        <Route
          path="/protect-yourself"
          component={ProtectYourself}
          exact={true}
        />
        <Route
          path="/who-mythbusters"
          component={WhoMythbusters}
          exact={true}
        />
        <Route path="/travel-advice" component={TravelAdvice} exact={true} />
        <Route
          path="/"
          render={() => <Redirect to="/splash-title" />}
          exact={true}
        />
      </IonRouterOutlet>
    </IonReactRouter>
  </IonApp>
);

export default App;
