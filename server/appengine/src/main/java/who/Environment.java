package who;

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

    switch (applicationId) {
      case "who-myhealth-staging":
        return STAGING;
      case "who-myhealth-hacker":
        return HACKER;
      case "myhealthapp-291008":
        return PRODUCTION;
      case "test":
        return TEST;
      case AppEngine.DEVELOPMENT_ID:
        return DEV_LOCAL;
      default:
        return DEV_SERVER;
    }
  }

  private static String getApplicationId() {
    String applicationId = AppEngine.applicationId();
    // "o~" prefix bug in App Engine. Not sure where those 2 chars at the beginning come from.
    final String PREFIX_BUG = "o~";
    if (applicationId.startsWith(PREFIX_BUG)) {
      applicationId = applicationId.substring(PREFIX_BUG.length());
    }
    return applicationId;
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
