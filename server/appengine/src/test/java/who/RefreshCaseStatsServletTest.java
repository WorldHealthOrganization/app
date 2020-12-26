package who;

import static org.junit.Assert.assertEquals;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;
import java.util.zip.GZIPInputStream;
import org.junit.Test;

public class RefreshCaseStatsServletTest extends WhoTestSupport {

  @Test
  public void testParse() throws UnsupportedEncodingException {
    RefreshCaseStatsServlet servlet = new RefreshCaseStatsServlet();

    InputStream in =
      this.getClass()
        .getClassLoader()
        .getResourceAsStream("smaller-who-data.json");
    JsonObject root = JsonParser
      .parseReader(new InputStreamReader(in, "UTF-8"))
      .getAsJsonObject();
    JsonArray rows = root.getAsJsonArray("features");

    RefreshCaseStatsServlet.JurisdictionData globalData = new RefreshCaseStatsServlet.JurisdictionData();
    Map<String, RefreshCaseStatsServlet.JurisdictionData> countryData = new HashMap<>();

    servlet.processWhoStats(rows, countryData, globalData);

    // Test values in a cumbersome way.
    // TODO: Test against a snapshot of golden data.
    assertEquals(1608768000000L, globalData.lastUpdated);
    assertEquals(235, globalData.totalCases);
    assertEquals(8, globalData.totalDeaths);
    assertEquals(2, globalData.snapshots.size());

    assertEquals(2, countryData.size());
    RefreshCaseStatsServlet.JurisdictionData zambia = countryData.get("ZM");
    assertEquals(2, zambia.snapshots.size());
    StoredCaseStats.StoredStatSnapshot s1 = zambia.snapshots.get(
      1608681600000L
    );
    assertEquals(113, s1.dailyCases.intValue());
  }

  @Test
  public void testDec24Data() throws IOException {
    RefreshCaseStatsServlet servlet = new RefreshCaseStatsServlet();

    InputStream inCompressed =
      this.getClass()
        .getClassLoader()
        .getResourceAsStream("who-data-24dec2020.json.gz");
    GZIPInputStream decompressed = new GZIPInputStream(inCompressed);
    JsonObject root = JsonParser
      .parseReader(new InputStreamReader(decompressed, "UTF-8"))
      .getAsJsonObject();
    JsonArray rows = root.getAsJsonArray("features");

    RefreshCaseStatsServlet.JurisdictionData globalData = new RefreshCaseStatsServlet.JurisdictionData();
    Map<String, RefreshCaseStatsServlet.JurisdictionData> countryData = new HashMap<>();

    servlet.processWhoStats(rows, countryData, globalData);

    assertEquals(1608768000000L, globalData.lastUpdated);
    // The TotalCases is a good heuristic that the data loaded correctly: it is a sum
    // of every daily case seen in the system so far.
    assertEquals(77530799L, globalData.totalCases);
  }
}
