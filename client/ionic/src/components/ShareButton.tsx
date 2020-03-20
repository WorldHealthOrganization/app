import React, { useState } from "react";
import { IonContent, IonButton } from "@ionic/react";
import { SocialSharing } from '@ionic-native/social-sharing';


interface ShareConfig {
    shareSTR: string;
  }

const ShareButton: React.FC<ShareConfig> = ({ shareSTR }) => {
    function share(){
        SocialSharing.share(shareSTR)
    }
    return (
        <IonContent>
             <IonButton
              onClick={share}
              expand="block"
            >
              Share
            </IonButton>
          </IonContent>
    );
  };

  export default ShareButton;
