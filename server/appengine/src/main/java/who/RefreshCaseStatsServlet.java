package who;

import com.google.common.annotations.VisibleForTesting;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonNull;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.IOException;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.jetbrains.annotations.NotNull;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RefreshCaseStatsServlet extends HttpServlet {

  @VisibleForTesting
  static final class JurisdictionData {

    JurisdictionType jurisdictionType;
    String jurisdiction;
    long totalCases = 0L, totalDeaths = 0L;
    long lastUpdated = 0L;
    Map<Long, StoredCaseStats.StoredStatSnapshot> snapshots = new HashMap<>();

    JurisdictionData(JurisdictionType jurisdictionType, String jurisdiction) {
      this.jurisdictionType = jurisdictionType;
      this.jurisdiction = jurisdiction;
    }
  }

  // Triggers to reject case stats update for unexpectedly large increase
  // Tuned to only trigger a handful of time in early pandemic and never since April 1st
  // Largest Cases Stats increase was 15.2% on March 24th
  // Triggers are cumulative rather than triggered separately
  private static final double TOTAL_CASES_MAX_DAILY_INCREASE_FACTOR = 1.05;
  private static final double TOTAL_CASES_MAX_DAILY_INCREASE_ABS = 30_000;

  private static final String WHO_CASE_STATS_URL =
    "https://services.arcgis.com/5T5nSi527N4F7luB/ArcGIS/rest/services/COVID_19_Historic_cases_by_country_pt_v7_view/FeatureServer/0/query?where=1%3D1&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&resultType=none&distance=0.0&units=esriSRUnit_Meter&returnGeodetic=false&outFields=ISO_2_CODE%2Cdate_epicrv%2CNewCase%2CCumCase%2CNewDeath%2CCumDeath%2C+ADM0_NAME&returnGeometry=false&featureEncoding=esriDefault&multipatchOption=xyFootprint&maxAllowableOffset=&geometryPrecision=&outSR=&datumTransformation=&applyVCSProjection=false&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&returnQueryGeometry=false&returnDistinctValues=false&cacheHint=false&groupByFieldsForStatistics=&outStatistics=&having=&resultRecordCount=&returnZ=false&returnM=false&returnExceededLimitFeatures=true&quantizationParameters=&sqlFormat=none&f=pjson&orderByFields=date_epicrv&token=";
  private static final Logger logger = LoggerFactory.getLogger(
    RefreshCaseStatsServlet.class
  );
  private static final OkHttpClient HTTP_CLIENT = new OkHttpClient();

  private String getDashboardContents(int offset) throws IOException {
    Request request = new Request.Builder()
      // Safe because the value is an integer and does not need to be escaped
      .url(WHO_CASE_STATS_URL + "&resultOffset=" + offset)
      .build();
    logger.info("ArcGIS url: " + request.url().toString());
    try (Response response = HTTP_CLIENT.newCall(request).execute()) {
      String data = response.body().string();
      logger.info("ArcGIS response length: " + data.length());
      return data;
    }
  }

  private static void updateData(
    JurisdictionData data,
    long timestamp,
    long dailyDeaths,
    long totalDeaths,
    long dailyCases,
    long totalCases
  ) {
    if (timestamp > data.lastUpdated) {
      data.lastUpdated = timestamp;
    }
    // Note that data.totalCases is a sum of dailyCases,
    // while snapshot.totalCases is simply copied from the input data.
    // The totalCases at the most recent snapshot should match
    // data.totalCases, but this system does not verify that.
    data.totalCases += dailyCases;
    data.totalDeaths += dailyDeaths;
    StoredCaseStats.StoredStatSnapshot snapshot = data.snapshots.get(timestamp);
    if (snapshot == null) {
      snapshot = new StoredCaseStats.StoredStatSnapshot();
      snapshot.epochMsec = timestamp;
      snapshot.dailyCases = 0L;
      snapshot.dailyDeaths = 0L;
      snapshot.totalCases = 0L;
      snapshot.totalDeaths = 0L;
      data.snapshots.put(timestamp, snapshot);
    } else if (data.jurisdictionType != JurisdictionType.GLOBAL) {
      // For individual jurisdictions, we should NOT see the same timestamp
      // more than once.
      // Fail and hope that the next run of the cron job succeeds.
      // Note that when the bad results are doubled/trebled/etc, they have
      // also been missing data, so ignoring duplicates is not safe.
      logger.error(
        "Duplicate country data found at {} for {} {}",
        timestamp,
        data.jurisdictionType,
        data.jurisdiction
      );

      // Todo: Create a proper exception.
      throw new RuntimeException("Saw duplicated country data.");
    }

    snapshot.dailyCases += dailyCases;
    snapshot.dailyDeaths += dailyDeaths;
    snapshot.totalCases += totalCases;
    snapshot.totalDeaths += totalDeaths;
  }

  /**
   * Process the JSON data returned by the ArcGIS server.
   *
   * @param rows        JSON Data from ArcGIS server
   * @param countryData Accumulated data for each country.
   * @param globalData  Accumulated data, sum of all countries.
   */
  @VisibleForTesting
  void processWhoStats(
    JsonArray rows,
    Map<String, JurisdictionData> countryData,
    JurisdictionData globalData
  ) {
    // Given that each row has heterogeneous elements, not sure there is much benefit
    // to using gson with reflection here.
    for (JsonElement feature : rows) {
      JsonElement attributesElement = feature
        .getAsJsonObject()
        .get("attributes");

      JsonObject attributes = attributesElement.getAsJsonObject();

      long timestamp = attributes.get("date_epicrv").getAsLong();
      long dailyDeaths = attributes.get("NewDeath").getAsLong();
      long totalDeaths = attributes.get("CumDeath").getAsLong();
      long dailyCases = attributes.get("NewCase").getAsLong();
      long totalCases = attributes.get("CumCase").getAsLong();

      updateData(
        globalData,
        timestamp,
        dailyDeaths,
        totalDeaths,
        dailyCases,
        totalCases
      );

      if (!(attributes.get("ISO_2_CODE") instanceof JsonNull)) {
        String isoCode = attributes.get("ISO_2_CODE").getAsString();
        JurisdictionData country = countryData.get(isoCode);
        if (country == null) {
          country = new JurisdictionData(JurisdictionType.COUNTRY, isoCode);
          countryData.put(isoCode, country);
        }
        updateData(
          country,
          timestamp,
          dailyDeaths,
          totalDeaths,
          dailyCases,
          totalCases
        );
      }
    }
  }

  /**
   * Correct partial last day
   *
   * CountryData last day dropped if likely "No Data Reported"
   * GlobalData totals to use all data, not sum of possible incomplete countries
   *
   * @param countryData Accumulated data for each country.
   * @param globalData Accumulated data, sum of all countries.
   */
  @VisibleForTesting
  void fixPartialLastDayAll(
    Map<String, JurisdictionData> countryData,
    who.RefreshCaseStatsServlet.JurisdictionData globalData
  ) {
    // Global last snapshot
    // Last day snapshot daily cases and deaths may remain as partial
    StoredCaseStats.StoredStatSnapshot snapshot = globalData.snapshots.get(
      globalData.lastUpdated
    );
    snapshot.totalCases = globalData.totalCases;
    snapshot.totalDeaths = globalData.totalDeaths;

    String countriesLastDayRemoved = "";
    for (Map.Entry<String, JurisdictionData> countryEntry : countryData.entrySet()) {
      boolean removed = fixPartialLastDayCountry(countryEntry.getValue());
      if (removed) {
        countriesLastDayRemoved += countryEntry.getKey() + ", ";
      }
    }
    logger.info("Countries last day removed: " + countriesLastDayRemoved);
  }

  /**
   * Remove last day if it appears to be "No Data Reported"
   *
   * ArcGIS data can distinguish between "Zero Cases" and "No Data Reported"
   * but appears to often report the former when it means the latter
   *
   * Heuristic:
   *   if lastDayNumbers > 0 => assume up to date
   *   if lastDayNumbers == 0 && priorDayNumbers > 0 => assume "No Data Reported" and delete
   * Will cause a 1-day delay when country goes to zero for the first time but better
   * than erroneously reporting the numbers as zero
   * https://github.com/WorldHealthOrganization/app/issues/1724
   *
   * @param countryData Accumulated data for a country.
   */
  @VisibleForTesting
  boolean fixPartialLastDayCountry(JurisdictionData countryData) {
    long lastUpdate = 0L;
    long priorUpdate = 0L;

    // Find two highest timestamps in the snapshot map
    for (Map.Entry<Long, StoredCaseStats.StoredStatSnapshot> entry : countryData.snapshots.entrySet()) {
      long update = entry.getKey();
      if (update > priorUpdate) {
        if (update > lastUpdate) {
          priorUpdate = lastUpdate;
          lastUpdate = update;
        } else {
          priorUpdate = update;
        }
      }
    }

    // Consider removing last day
    if (lastUpdate > 0 && priorUpdate > 0) {
      StoredCaseStats.StoredStatSnapshot lastSnapshot = countryData.snapshots.get(
        lastUpdate
      );
      StoredCaseStats.StoredStatSnapshot priorSnapshot = countryData.snapshots.get(
        priorUpdate
      );
      if (lastSnapshot.dailyCases == 0 && lastSnapshot.dailyDeaths == 0) {
        if (priorSnapshot.dailyCases > 0 || priorSnapshot.dailyDeaths > 0) {
          // Likely "No Data Reported"
          StoredCaseStats.StoredStatSnapshot removed = countryData.snapshots.remove(
            lastUpdate
          );
          countryData.lastUpdated = priorUpdate;
          return true;
        }
      }
    }
    return false;
  }

  /**
   * Generate a CaseStats record suitable for saving to the datastore from JurisdictionData.
   */
  @NotNull
  private CaseStats buildCaseStats(JurisdictionData data) {
    CaseStats.Builder countryStats = new CaseStats.Builder()
      .jurisdictionType(data.jurisdictionType)
      .jurisdiction(data.jurisdiction)
      .cases(data.totalCases)
      .deaths(data.totalDeaths)
      .lastUpdated(data.lastUpdated)
      .recoveries(-1L)
      .timeseries(
        data.snapshots
          .entrySet()
          .stream()
          .sorted(Comparator.comparing(Map.Entry::getKey))
          .map(Map.Entry::getValue)
          .map(StoredCaseStats.StoredStatSnapshot::toStatSnapshot)
          .collect(Collectors.toList())
      )
      .attribution("WHO");
    return countryStats.build();
  }

  @Override
  protected void doGet(
    HttpServletRequest request,
    HttpServletResponse response
  ) throws IOException {
    // App Engine strips all external X-* request headers, so we can trust this is set by App Engine.
    // https://cloud.google.com/appengine/docs/flexible/java/scheduling-jobs-with-cron-yaml#validating_cron_requests
    if (
      !(
        Environment.current() == Environment.DEV_LOCAL ||
        "true".equals(request.getHeader("X-Appengine-Cron"))
      )
    ) {
      response.sendError(
        HttpServletResponse.SC_UNAUTHORIZED,
        "Cron access only"
      );
      return;
    }

    JurisdictionData globalData = new JurisdictionData(
      JurisdictionType.GLOBAL,
      ""
    );
    Map<String, JurisdictionData> countryData = new HashMap<>();

    int numItems = 0;

    while (true) {
      String jsonString = getDashboardContents(numItems);

      JsonObject root = JsonParser.parseString(jsonString).getAsJsonObject();

      JsonArray rows = root.getAsJsonArray("features");
      if (rows == null || rows.size() == 0) {
        logger.info("Retreived no features.");
        break;
      }
      logger.info("Retreived {} features.", rows.size());
      numItems += rows.size();
      processWhoStats(rows, countryData, globalData);
    }
    fixPartialLastDayAll(countryData, globalData);

    // Reject unexpected changes in case stats, e.g. too large an increase
    CaseStats oldCaseStats = StoredCaseStats.load(JurisdictionType.GLOBAL, "");
    if (oldCaseStats != null) {
      totalCasesDeltaCheck(oldCaseStats.cases, globalData.totalCases);
    }

    StoredCaseStats.save(buildCaseStats(globalData));

    for (Map.Entry<String, JurisdictionData> entry : countryData.entrySet()) {
      StoredCaseStats.save(buildCaseStats(entry.getValue()));
    }
    logger.info("Results saved.");
  }

  @VisibleForTesting
  void totalCasesDeltaCheck(long oldTotalCases, long newTotalCases)
    throws RuntimeException {
    long thresholdTotalCases = (long) (
      ((double) oldTotalCases * TOTAL_CASES_MAX_DAILY_INCREASE_FACTOR) +
      TOTAL_CASES_MAX_DAILY_INCREASE_ABS
    );
    if (newTotalCases > thresholdTotalCases || newTotalCases < oldTotalCases) {
      logger.error(
        "Unexpected delta in global cases. Old total: {}, New total: {}",
        oldTotalCases,
        newTotalCases
      );
      throw new RuntimeException("Unexpected delta in global cases.");
    }
  }
}
