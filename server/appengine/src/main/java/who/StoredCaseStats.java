package who;

import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

import static com.googlecode.objectify.ObjectifyService.ofy;

@Entity @Cache(expirationSeconds=120)
public class StoredCaseStats {
  // $jurisdictionType:$jurisdiction
  @Id String jurisdictionKey;

  // The protobuf itself lacks a no-arg constructor so
  // we have to copy all the fields here.

  public JurisdictionType jurisdictionType;

  public String jurisdiction;

  public Long lastUpdated;

  public Long cases;

  public Long deaths;

  public Long recoveries;

  public String attribution;

  public static void save(CaseStats stats) {
    StoredCaseStats s = new StoredCaseStats();
    s.jurisdictionType = stats.jurisdictionType;
    s.jurisdiction = stats.jurisdiction;
    s.lastUpdated = stats.lastUpdated;
    s.cases = stats.cases;
    s.deaths = stats.deaths;
    s.recoveries = stats.recoveries;
    s.attribution = stats.attribution;
    s.jurisdictionKey = stats.jurisdictionType.getValue() + ":" + stats.jurisdiction;
    ofy().save().entities(s).now();
  }

  public static CaseStats load(JurisdictionType type, String jurisdiction) {
    StoredCaseStats ret = ofy().load().type(StoredCaseStats.class).id(type.getValue() + ":" + jurisdiction).now();
    if (ret == null) {
      return null;
    }
    return new CaseStats.Builder()
      .jurisdictionType(ret.jurisdictionType)
      .jurisdiction(ret.jurisdiction)
      .lastUpdated(ret.lastUpdated)
      .cases(ret.cases)
      .deaths(ret.deaths)
      .recoveries(ret.recoveries)
      .attribution(ret.attribution)
      .build();
  }
}
