import React, { ReactNode } from 'react';
import TopNav from '../components/TopNav';
import { IonButton, IonContent, IonPage } from '@ionic/react';
import 'tachyons';

const MenuItem = ({
  link,
  children,
  fill,
}: {
  link: string;
  children: ReactNode;
  fill?: boolean;
}) => {
  const buttonStyle = {
    fontWeight: 'bold',
    height: 60,
    fontSize: '1.5em',
    textTransform: 'none',
    '--border-radius': '10px',
    letterSpacing: 'normal',
  };
  return (
    <div>
      <IonButton
        expand="block"
        routerLink={link}
        className="tc"
        fill={fill ? 'solid' : 'outline'}
        style={buttonStyle}
      >
        {children}
      </IonButton>
    </div>
  );
};

const Menu: React.FC = () => {
  return (
    <IonPage className="pa3">
      <TopNav showClose={false} linkify={false} />
      <IonContent>
        <div className="flex flex-column h-100 justify-around pt3 pb6 ph4">
          <MenuItem fill link="/protect-yourself">
            Protect Yourself
          </MenuItem>
          <MenuItem fill link="/check-your-health">
            Check Your Health
          </MenuItem>
          <MenuItem fill link="/who-mythbusters">
            WHO Myth-busters
          </MenuItem>
          <MenuItem link="/about">Share the App</MenuItem>
          <MenuItem link="/about">About the App</MenuItem>
        </div>
      </IonContent>
    </IonPage>
  );
};

export default Menu;
