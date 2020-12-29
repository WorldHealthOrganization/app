package who;

import static com.google.appengine.api.appidentity.AppIdentityServiceFactory.getAppIdentityService;

import com.google.appengine.api.appidentity.AppIdentityService;
import com.google.appengine.api.utils.SystemProperty;
import present.engine.AppEngine;

/**
 * Exposes information specific to the current server environment.
 */
public enum Environment {
  TEST("http://localhost:3000"),
  DEV_LOCAL("http://localhost:3000"),
  DEV_SERVER("https://%s.appspot.com"),
  STAGING("https://staging.whocoronavirus.org"),
  HACKER("https://hacker.whocoronavirus.org"),
  PRODUCTION("https://myhealth.who.int");

  private final String url;

  Environment(String url) {
    this.url = url;
  }

  /** Returns the URL for our server. */
  public String url() {
    if (this == DEV_SERVER) {
      return this.url.format(getApplicationId());
    }
    return this.url;
  }

  /** Returns the current environment. */
  public static Environment current() {
    String applicationId = getApplicationId();

    if (applicationId == null) return TEST;

    if (
      SystemProperty.environment.value() ==
      SystemProperty.Environment.Value.Development
    ) {
      return DEV_LOCAL;
    }

    switch (applicationId) {
      case "who-myhealth-staging":
        return STAGING;
      case "who-myhealth-hacker":
        return HACKER;
      case "myhealthapp-291008":
        return PRODUCTION;
      case "test":
        return TEST;
      default:
        return DEV_SERVER;
    }
  }

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

  public String firebaseApplicationId() {
    switch (this) {
      case TEST:
      case DEV_LOCAL:
        return "who-myhealth-staging";
      case DEV_SERVER:
      case STAGING:
      case HACKER:
      case PRODUCTION:
      default:
        // Firebase and App Engine names should match
        return getApplicationId();
    }
  }

  /** True if this is the production server. */
  public static boolean isProduction() {
    Environment current = current();
    return current == PRODUCTION || current == HACKER;
  }
}
