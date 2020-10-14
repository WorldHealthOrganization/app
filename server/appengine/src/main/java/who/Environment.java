package who;

import present.engine.AppEngine;

/**
 * Exposes information specific to the current server environment.
 */
public enum Environment {
  TEST("http://localhost:3000"),
  DEVELOPMENT("http://localhost:3000"),
  STAGING("https://staging.whocoronavirus.org"),
  HACKER_ONE("https://hackerone.whocoronavirus.org"),
  PRODUCTION("https://whoapp.org");

  private final String url;

  Environment(String url) {
    this.url = url;
  }

  /** Returns the URL for our server. */
  public String url() {
    return this.url;
  }

  /** Returns the current environment. */
  public static Environment current() {
    String applicationId = AppEngine.applicationId();
    if (applicationId == null) return TEST;

    switch (applicationId) {
      case "who-myhealth-staging":
        return STAGING;
      case "who-myhealth-hackerone":
        return HACKER_ONE;
      case "who-myhealth-europe":
        return PRODUCTION;
      // Workaround for bug in App Engine. Not sure where those 2 chars at the beginning come from.
      case "o~who-myhealth-europe":
      case "o~myhealthapp-291008":
        return PRODUCTION;
      case "test":
        return TEST;
      case AppEngine.DEVELOPMENT_ID:
        return DEVELOPMENT;
      default:
        throw new RuntimeException(
          "Unrecognized application ID: " + applicationId
        );
    }
  }

  public String firebaseApplicationId() {
    switch (this) {
      case TEST:
      case DEVELOPMENT:
      case STAGING:
        return "who-myhealth-staging";
      case HACKER_ONE:
        return "who-myhealth-hackerone";
      case PRODUCTION:
        return "who-myhealth-europe";
      default:
        throw new RuntimeException("Unrecognized environment: " + this);
    }
  }

  /** True if this is the development server. */
  public static boolean isDevelopment() {
    return current() == DEVELOPMENT;
  }

  /** True if this is the production server. */
  public static boolean isProduction() {
    Environment current = current();
    return current == PRODUCTION || current == HACKER_ONE;
  }

  /** True if this is the staging server. */
  public static boolean isStaging() {
    return current() == STAGING;
  }

  /** True if this is a server. */
  public static boolean isServer() {
    Environment current = current();
    return (
      current == DEVELOPMENT ||
      current == STAGING ||
      current == HACKER_ONE ||
      current == PRODUCTION
    );
  }

  /** True if this is a test. */
  public static boolean isTest() {
    return current() == TEST;
  }
}
