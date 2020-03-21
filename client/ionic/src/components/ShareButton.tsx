import React from 'react';
import { IonButton } from '@ionic/react';
import { SocialSharing } from '@ionic-native/social-sharing';

interface ShareConfig {
  message: string;
}

const ShareButton: React.FC<ShareConfig> = ({ message }) => {
  return (
    <IonButton shape="round" onClick={() => shareMessage(message)}>
      Share
    </IonButton>
  );
};

function shareMessage(message: string) {
  SocialSharing.share(message);
}
export default ShareButton;
export { shareMessage };
