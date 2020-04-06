package who;

import com.google.common.geometry.S2CellId;
import com.google.common.geometry.S2LatLng;
import java.io.IOException;

import static com.googlecode.objectify.ObjectifyService.ofy;

public class WhoServiceImpl implements WhoService {

  @Override public Void putDeviceToken(PutDeviceTokenRequest request) throws IOException {
    Client client = Client.current();
    client.token = request.token;
    ofy().save().entities(client);
    return new Void();
  }

  @Override public Void putLocation(PutLocationRequest request) throws IOException {
    Client client = Client.current();
    client.latitude = request.latitude;
    client.longitude = request.longitude;
    S2LatLng coordinates = S2LatLng.fromDegrees(request.latitude, request.longitude);
    client.location = S2CellId.fromLatLng(coordinates).id();
    ofy().save().entities(client);
    return new Void();
  }

  // 10 mins
  private static final long STATS_TTL_SECONDS = 60 * 10;

  @Override public GetCaseStatsResponse getCaseStats(Void request) {
      
    // TODO: Get from data source.
    return new GetCaseStatsResponse.Builder()
      .globalStats(new CaseStats.Builder()
        .cases(1136851L)
        .deaths(62955L)
        // 2020-04-05 18:00 CET
        .lastUpdated(1586102400000L)
        // TODO: Unsure whether we can get an efficient query for recoveries in real-time.
        .recoveries(-1L)
        .attribution("WHO")
        .build()
      )
      .ttl(STATS_TTL_SECONDS)
      .build();
  }
}
