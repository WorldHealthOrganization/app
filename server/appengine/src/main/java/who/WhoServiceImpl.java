package who;

import com.google.common.base.Strings;
import com.google.common.geometry.S2CellId;
import com.google.common.geometry.S2LatLng;
import present.rpc.ClientException;
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
    S2CellId location = S2CellId.fromToken(request.s2CellIdToken);
    if (!location.isValid()) {
      throw new ClientException("Invalid s2CellId");
    }
    if (location.level() > Client.MAX_S2_CELL_LEVEL) {
      throw new ClientException("s2CellId level too high");
    }
    client.location = location.id();
    // Center of the cell.
    S2LatLng point = location.toLatLng();
    client.latitude = point.latDegrees();
    client.longitude = point.lngDegrees();
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
