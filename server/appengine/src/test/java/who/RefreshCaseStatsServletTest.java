package who;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThrows;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

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
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.junit.Test;
import org.mockito.ArgumentCaptor;

public class RefreshCaseStatsServletTest {

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
  public void testCronFailsOutsideDevAppserver() throws Exception {
    HttpServletRequest request = mock(HttpServletRequest.class);
    HttpServletResponse response = mock(HttpServletResponse.class);

    new RefreshCaseStatsServlet().doGet(request, response);

    verify(response)
      .sendError(HttpServletResponse.SC_UNAUTHORIZED, "Cron access only");
  }

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
    assertEquals(302, globalData.totalCases);
    assertEquals(32, globalData.totalDeaths);
    assertEquals(2, globalData.snapshots.size());

    assertEquals(2, countryData.size());
    RefreshCaseStatsServlet.JurisdictionData zambia = countryData.get("AA");
    assertEquals(2, zambia.snapshots.size());
    StoredCaseStats.StoredStatSnapshot s1 = zambia.snapshots.get(
      1608681600000L
    );
    assertEquals(100, s1.dailyCases.intValue());
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

    JsonArray rows1 = getRowsFromTestResource("smaller-who-data.json");
    JsonArray rows2 = getRowsFromTestResource("smaller-who-data-page-2.json");

    RefreshCaseStatsServlet.JurisdictionData globalData = new RefreshCaseStatsServlet.JurisdictionData(
      JurisdictionType.GLOBAL,
      ""
    );
    Map<String, RefreshCaseStatsServlet.JurisdictionData> countryData = new HashMap<>();

    servlet.processWhoStats(rows1, countryData, globalData);
    assertEquals(1608768000000L, globalData.lastUpdated);
    assertEquals(302, globalData.totalCases);
    assertEquals(32, globalData.totalDeaths);
    assertEquals(2, globalData.snapshots.size());

    servlet.processWhoStats(rows2, countryData, globalData);
    assertEquals(1608854400000L, globalData.lastUpdated);
    assertEquals(403, globalData.totalCases);
    assertEquals(43, globalData.totalDeaths);
    assertEquals(3, globalData.snapshots.size());
  }

  @Test
  public void testPartialLastDay() throws UnsupportedEncodingException {
    /*
    Data from json file:
    AA: non-zero data for all 3 days
    BB: zero numbers for last 1 day (discarded last day as likely "no data reported")
    CC: zero numbers for last 2 days (kept as likely "valid zero following prior zero")
    DD: no entry at all for last timestamp (incomplete timestamp for global data)

    Presented here grouped by country for readability.
    File is sorted by timestamp and then country.

    Timestamp, Country, dailyCases, sumCases, dailyDeaths, sumDeaths
    1608681600000, AA, 100, 100, 10, 10,
    1608768000000, AA, 100, 200, 10, 20,
    1608854400000, AA, 100, 300, 10, 30,
    1608681600000, BB, 101, 101, 11, 11,
    1608768000000, BB, 101, 202, 11, 22,
    1608854400000, BB,   0, 202,  0, 22,
    1608681600000, CC, 102, 102, 12, 12,
    1608768000000, CC,   0, 102,  0, 12,
    1608854400000, CC,   0, 102,  0, 12,
    1608681600000, DD, 400, 400, 80, 80,
     */
    JsonArray rows = getRowsFromTestResource(
      "smaller-who-data-partial-last-day.json"
    );

    RefreshCaseStatsServlet servlet = new RefreshCaseStatsServlet();
    RefreshCaseStatsServlet.JurisdictionData globalData = new RefreshCaseStatsServlet.JurisdictionData(
      JurisdictionType.GLOBAL,
      ""
    );
    Map<String, RefreshCaseStatsServlet.JurisdictionData> countryData = new HashMap<>();

    servlet.processWhoStats(rows, countryData, globalData);
    servlet.fixPartialLastDayAll(countryData, globalData);

    // Global Stats
    assertEquals(1608854400000L, globalData.lastUpdated);
    assertEquals(300 + 202 + 102 + 400, globalData.totalCases);
    assertEquals(30 + 22 + 12 + 80, globalData.totalDeaths);
    assertEquals(3, globalData.snapshots.size());
    StoredCaseStats.StoredStatSnapshot g1 = globalData.snapshots.get(
      1608681600000L
    );
    StoredCaseStats.StoredStatSnapshot g2 = globalData.snapshots.get(
      1608768000000L
    );
    StoredCaseStats.StoredStatSnapshot g3 = globalData.snapshots.get(
      1608854400000L
    );

    // No partial day as there's no missing data
    assertEquals(100 + 101 + 102 + 400, (long) g1.totalCases);
    // Partial day mistakenly misses DD: 400
    assertEquals(200 + 202 + 102, (long) g2.totalCases);
    // Partial day is corrected to match globalData.totalCases
    assertEquals(300 + 202 + 102 + 400, (long) g3.totalCases);

    // Country Stats
    RefreshCaseStatsServlet.JurisdictionData aaCountry = countryData.get("AA");
    RefreshCaseStatsServlet.JurisdictionData bbCountry = countryData.get("BB");
    RefreshCaseStatsServlet.JurisdictionData ccCountry = countryData.get("CC");

    assertNotNull(aaCountry);
    assertNotNull(bbCountry);
    assertNotNull(ccCountry);

    // AA: non-zero data for all 3 days
    assertEquals(3, aaCountry.snapshots.size());
    // BB: zero numbers for last 1 day (discarded last day as likely "no data reported")
    assertEquals(2, bbCountry.snapshots.size());
    // CC: zero numbers for last 2 days (kept as likely "valid zero following prior zero")
    assertEquals(3, ccCountry.snapshots.size());
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
    assertEquals(1724904L, globalData.totalDeaths);

    RefreshCaseStatsServlet.JurisdictionData us = countryData.get("US");
    assertEquals(357, us.snapshots.size());
    // Last entry would be removed by fixPartialLastDayAll
    RefreshCaseStatsServlet.JurisdictionData ng = countryData.get("RW");
    assertEquals(357, ng.snapshots.size());
  }

  @Test
  public void totalCasesDeltaCheck() {
    RefreshCaseStatsServlet servlet = new RefreshCaseStatsServlet();
    servlet.totalCasesDeltaCheck(1000, 2000);
    servlet.totalCasesDeltaCheck(77_000_000, 78_000_000);

    // Unexpected increase
    Exception exception1 = assertThrows(
      RuntimeException.class,
      () -> {
        servlet.totalCasesDeltaCheck(77_000_000, 82_000_000);
      }
    );

    // Unexpected decrease
    Exception exception2 = assertThrows(
      RuntimeException.class,
      () -> {
        servlet.totalCasesDeltaCheck(77_000_000, 76_999_999);
      }
    );
  }
}
