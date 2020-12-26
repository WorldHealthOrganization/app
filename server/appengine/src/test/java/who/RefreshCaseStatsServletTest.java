package who;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.*;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.junit.Test;
import org.mockito.ArgumentCaptor;

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

    assertEquals(2, countryData.size());
  }
}
