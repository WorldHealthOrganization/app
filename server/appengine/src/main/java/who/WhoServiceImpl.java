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

  @Override public GetCaseStatsResponse getCaseStats(Void request) throws IOException {
    CaseStats global = StoredCaseStats.load(JurisdictionType.GLOBAL, "");
    return new GetCaseStatsResponse.Builder()
      .globalStats(global)
      .ttl(STATS_TTL_SECONDS)
      .build();
  }
}
