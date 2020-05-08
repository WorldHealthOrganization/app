package who;

import com.google.gson.JsonParser;
import com.google.gson.JsonElement;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;
import java.io.IOException;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class RefreshCaseStatsServlet extends HttpServlet {
  private static final String WHO_CASE_STATS_URL = "https://services.arcgis.com/5T5nSi527N4F7luB/arcgis/rest/services/COVID19_hist_cases_adm0_v5_view/FeatureServer/0/query?where=1%3D1&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&resultType=none&distance=0.0&units=esriSRUnit_Meter&returnGeodetic=false&outFields=ISO_2_CODE%2Cdate_epicrv%2CNewCase%2CCumCase%2CNewDeath%2CCumDeath%2C+ADM0_NAME&returnGeometry=true&featureEncoding=esriDefault&multipatchOption=xyFootprint&maxAllowableOffset=&geometryPrecision=&outSR=&datumTransformation=&applyVCSProjection=false&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&returnQueryGeometry=false&returnDistinctValues=false&cacheHint=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&having=&resultOffset=&resultRecordCount=&returnZ=false&returnM=false&returnExceededLimitFeatures=true&quantizationParameters=&sqlFormat=none&f=pjson&token=";

  private static final OkHttpClient HTTP_CLIENT = new OkHttpClient();

  private String getDashboardContents() throws IOException {
    Request request = new Request.Builder()
        .url(WHO_CASE_STATS_URL)
        .build();
    try (Response response = HTTP_CLIENT.newCall(request).execute()) {
      return response.body().string();
    }
  }

  @Override protected void doGet(HttpServletRequest request, HttpServletResponse response)
          throws IOException {

    // App Engine strips all external X-* request headers, so we can trust this is set by App Engine.
    // https://cloud.google.com/appengine/docs/flexible/java/scheduling-jobs-with-cron-yaml#validating_cron_requests
    if (Environment.isProduction() && !"true".equals(request.getHeader("X-Appengine-Cron"))) {
      response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Cron access only");
      return;
    }

    String jsonString = getDashboardContents();

    JsonObject root = new JsonParser().parse(jsonString).getAsJsonObject();

    JsonArray rows = root.getAsJsonArray("features");

    long globalTotalCases = 0L, globalTotalDeaths = 0L;
    long lastUpdated = 0L;

    Map<Long, StoredCaseStats.StoredStatSnapshot> globalSnapshots = new HashMap<>();
    // Given that each row has heterogeneous elements, not sure there is much benefit
    // to using gson with reflection here.
    for (JsonElement feature : rows) {

      JsonObject featureAsJsonObject = feature.getAsJsonObject();
      JsonElement attributesElement = featureAsJsonObject.get("attributes");

      JsonObject attributes = attributesElement.getAsJsonObject();

      long timestamp = attributes.get("date_epicrv").getAsLong();

      if (timestamp>lastUpdated){
        lastUpdated = timestamp;
      }

      long dailyDeaths = attributes.get("NewDeath").getAsLong();

      long totalDeaths = attributes.get("CumDeath").getAsLong();

      long dailyCases = attributes.get("NewCase").getAsLong();

      long totalCases = attributes.get("CumCase").getAsLong();

      globalTotalCases += dailyCases;
      globalTotalDeaths += dailyDeaths;

      StoredCaseStats.StoredStatSnapshot snapshot = globalSnapshots.get(timestamp);

      if (snapshot == null) {
        snapshot = new StoredCaseStats.StoredStatSnapshot();
        snapshot.epochMsec = timestamp;
        snapshot.dailyCases = 0L;
        snapshot.dailyDeaths = 0L;
        snapshot.totalCases = 0L;
        snapshot.totalDeaths = 0L;
        globalSnapshots.put(timestamp, snapshot);
      }
      snapshot.dailyCases += dailyCases;
      snapshot.dailyDeaths += dailyDeaths;
      snapshot.totalCases += totalCases;
      snapshot.totalDeaths += totalDeaths;
    }

    CaseStats.Builder global = new CaseStats.Builder()
        .jurisdictionType(JurisdictionType.GLOBAL)
        .jurisdiction("")
        .cases(globalTotalCases)
        .deaths(globalTotalDeaths)
        .lastUpdated(lastUpdated)
        .recoveries(-1L)
        .timeseries(
            globalSnapshots.entrySet().stream()
            .sorted(Comparator.comparing(Map.Entry::getKey))
            .map(Map.Entry::getValue)
            .map(StoredCaseStats.StoredStatSnapshot::toStatSnapshot)
            .collect(Collectors.toList()))
        .attribution("WHO");

    StoredCaseStats.save(global.build());
  }
}
