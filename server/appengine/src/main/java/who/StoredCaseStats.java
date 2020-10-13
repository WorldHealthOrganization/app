package who;

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Entity
@Cache(expirationSeconds = 120)
public class StoredCaseStats {

  // $jurisdictionType:$jurisdiction
  @Id
  String jurisdictionKey;

  // The protobuf itself lacks a no-arg constructor so
  // we have to copy all the fields here.

  public JurisdictionType jurisdictionType;

  public String jurisdiction;

  public Long lastUpdated;

  public Long cases;

  public Long deaths;

  public Long recoveries;

  public String attribution;

  public List<StoredStatSnapshot> timeseries = new ArrayList<>();

  public static class StoredStatSnapshot {

    public Long epochMsec;

    public Long dailyCases;
    public Long dailyDeaths;
    public Long dailyRecoveries;

    public Long totalCases;
    public Long totalDeaths;
    public Long totalRecoveries;

    StatSnapshot toStatSnapshot() {
      return new StatSnapshot.Builder()
        .epochMsec(epochMsec)
        .dailyCases(dailyCases)
        .dailyDeaths(dailyDeaths)
        .dailyRecoveries(dailyRecoveries)
        .totalCases(totalCases)
        .totalDeaths(totalDeaths)
        .totalRecoveries(totalRecoveries)
        .build();
    }

    static StoredStatSnapshot fromStatSnapshot(StatSnapshot s) {
      StoredStatSnapshot r = new StoredStatSnapshot();
      r.epochMsec = s.epochMsec;
      r.dailyCases = s.dailyCases;
      r.dailyDeaths = s.dailyDeaths;
      r.dailyRecoveries = s.dailyRecoveries;
      r.totalCases = s.totalCases;
      r.totalDeaths = s.totalDeaths;
      r.totalRecoveries = s.totalRecoveries;
      return r;
    }
  }

  public static void save(CaseStats stats) {
    StoredCaseStats s = new StoredCaseStats();
    s.jurisdictionType = stats.jurisdictionType;
    s.jurisdiction = stats.jurisdiction;
    s.lastUpdated = stats.lastUpdated;
    s.cases = stats.cases;
    s.deaths = stats.deaths;
    s.recoveries = stats.recoveries;
    s.attribution = stats.attribution;
    s.jurisdictionKey =
      stats.jurisdictionType.getValue() + ":" + stats.jurisdiction;
    s.timeseries =
      stats.timeseries != null
        ? stats.timeseries
          .stream()
          .map(t -> StoredStatSnapshot.fromStatSnapshot(t))
          .collect(Collectors.toList())
        : new ArrayList<>();
    ofy().save().entities(s).now();
  }

  public static CaseStats load(JurisdictionType type, String jurisdiction) {
    StoredCaseStats ret = ofy()
      .load()
      .type(StoredCaseStats.class)
      .id(type.getValue() + ":" + jurisdiction)
      .now();
    if (ret == null) {
      return null;
    }
    List<StatSnapshot> timeseries = ret.timeseries != null
      ? ret.timeseries
        .stream()
        .map(StoredCaseStats.StoredStatSnapshot::toStatSnapshot)
        .collect(Collectors.toList())
      : new ArrayList<>();
    return new CaseStats.Builder()
      .jurisdictionType(ret.jurisdictionType)
      .jurisdiction(ret.jurisdiction)
      .lastUpdated(ret.lastUpdated)
      .cases(ret.cases)
      .deaths(ret.deaths)
      .recoveries(ret.recoveries)
      .attribution(ret.attribution)
      .timeseries(timeseries)
      .build();
  }
}
