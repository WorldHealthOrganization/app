package who;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThrows;

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

    JsonArray rows = getRowsFromTestResource("smaller-who-data.json");

    RefreshCaseStatsServlet.JurisdictionData globalData = new RefreshCaseStatsServlet.JurisdictionData(
      JurisdictionType.GLOBAL,
      ""
    );
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
  public void testDoubleData() throws UnsupportedEncodingException {
    RefreshCaseStatsServlet servlet = new RefreshCaseStatsServlet();

    JsonArray rows = getRowsFromTestResource("smaller-who-data.json");

    RefreshCaseStatsServlet.JurisdictionData globalData = new RefreshCaseStatsServlet.JurisdictionData(
      JurisdictionType.GLOBAL,
      ""
    );
    Map<String, RefreshCaseStatsServlet.JurisdictionData> countryData = new HashMap<>();

    servlet.processWhoStats(rows, countryData, globalData);
    // Imagine that the server is going haywire: it is called a second time,
    // and instead of returning new data (or no data), it returns previously
    // seen data! This may be what is triggering a bug where some countries
    // were seeing double or triple the correct values.
    Exception exception = assertThrows(
      RuntimeException.class,
      () -> {
        servlet.processWhoStats(rows, countryData, globalData);
      }
    );
  }

  @Test
  public void testPaginatedData() throws UnsupportedEncodingException {
    RefreshCaseStatsServlet servlet = new RefreshCaseStatsServlet();

    JsonArray rows1 = getRowsFromTestResource("smaller-who-data-earlier.json");
    JsonArray rows2 = getRowsFromTestResource("smaller-who-data.json");

    RefreshCaseStatsServlet.JurisdictionData globalData = new RefreshCaseStatsServlet.JurisdictionData(
      JurisdictionType.GLOBAL,
      ""
    );
    Map<String, RefreshCaseStatsServlet.JurisdictionData> countryData = new HashMap<>();

    servlet.processWhoStats(rows1, countryData, globalData);
    assertEquals(1608595200000L, globalData.lastUpdated);
    servlet.processWhoStats(rows2, countryData, globalData);

    assertEquals(1608768000000L, globalData.lastUpdated);
    assertEquals(384, globalData.totalCases);
    assertEquals(12, globalData.totalDeaths);
    assertEquals(3, globalData.snapshots.size());
  }

  private JsonArray getRowsFromTestResource(String filename)
    throws UnsupportedEncodingException {
    InputStream in =
      this.getClass().getClassLoader().getResourceAsStream(filename);
    JsonObject root = JsonParser
      .parseReader(new InputStreamReader(in, "UTF-8"))
      .getAsJsonObject();
    return root.getAsJsonArray("features");
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

    RefreshCaseStatsServlet.JurisdictionData globalData = new RefreshCaseStatsServlet.JurisdictionData(
      JurisdictionType.GLOBAL,
      ""
    );
    Map<String, RefreshCaseStatsServlet.JurisdictionData> countryData = new HashMap<>();

    servlet.processWhoStats(rows, countryData, globalData);

    assertEquals(1608768000000L, globalData.lastUpdated);
    // The TotalCases is a good heuristic that the data loaded correctly: it is a sum
    // of every daily case seen in the system so far.
    assertEquals(77530799L, globalData.totalCases);
  }
}
