package who;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.inject.AbstractModule;
import com.google.inject.Provides;
import java.io.IOException;
import javax.inject.Singleton;

public class FirebaseModule extends AbstractModule {

  @Provides
  @Singleton
  FirebaseApp provideFirebaseApp(Environment env) throws IOException {
    FirebaseOptions options = new FirebaseOptions.Builder()
      .setCredentials(GoogleCredentials.getApplicationDefault())
      .setDatabaseUrl(
        "https://" + env.firebaseApplicationId() + ".firebaseio.com"
      )
      .build();

    FirebaseApp.initializeApp(options);

    return FirebaseApp.getInstance();
  }

  @Provides
  @Singleton
  FirebaseMessaging provideFirebaseMessaging(FirebaseApp app) {
    return FirebaseMessaging.getInstance(app);
  }
}
