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
  PRODUCTION("https://whocoronavirus.org");

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
      case "who-myhealth-staging": return STAGING;
      case "who-myhealth-hackerone": return HACKER_ONE;
      case "who-myhealth-production": return PRODUCTION;
      case "test": return TEST;
      case AppEngine.DEVELOPMENT_ID: return DEVELOPMENT;
      default: throw new RuntimeException("Unrecognized application ID: " + applicationId);
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
    return current == DEVELOPMENT
        || current == STAGING
        || current == HACKER_ONE
        || current == PRODUCTION;
  }

  /** True if this is a test. */
  public static boolean isTest() {
    return current() == TEST;
  }
}
