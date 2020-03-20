import React, { useState } from "react";
import { IonContent, IonButton } from "@ionic/react";
import { SocialSharing } from "@ionic-native/social-sharing/";

interface ShareConfig {
  shareStr: string;
}

const ShareButton: React.FC<ShareConfig> = ({ shareStr }) => {
  function share() {
    SocialSharing.share(shareStr);
  }
  return (
    <IonContent>
      <IonButton onClick={share} expand="block">
        Share
      </IonButton>
    </IonContent>
  );
};

export default ShareButton;
