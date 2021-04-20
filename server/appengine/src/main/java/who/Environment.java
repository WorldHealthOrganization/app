package who;

import static com.google.appengine.api.appidentity.AppIdentityServiceFactory.getAppIdentityService;

import com.google.appengine.api.appidentity.AppIdentityService;
import com.google.appengine.api.utils.SystemProperty;
import present.engine.AppEngine;

/**
 * Exposes information specific to the current server environment.
 */
public final class Environment {

  private Environment() {}

  private static final String STAGING_PROJECT_ID = "who-mh-staging";

  private static String getApplicationId() {
    String applicationId = AppEngine.applicationId();
    if (applicationId == null) {
      return null;
    }

    // Work around https://github.com/presentco/present-engine/issues/1
    AppIdentityService.ParsedAppId id = getAppIdentityService()
      .parseFullAppId(applicationId);
    return id.getId();
  }

  public static String firebaseApplicationId() {
    if (isDevLocal()) {
      return STAGING_PROJECT_ID;
    }
    return getApplicationId();
  }

  /** True if this is a development server. */
  public static boolean isDevLocal() {
    return (
      SystemProperty.environment.value() ==
      SystemProperty.Environment.Value.Development
    );
  }
}
