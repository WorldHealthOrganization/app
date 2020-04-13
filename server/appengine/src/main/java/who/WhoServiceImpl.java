package who;

import com.google.common.base.Strings;
import com.google.common.geometry.S2CellId;
import com.google.common.geometry.S2LatLng;
import com.google.inject.Inject;

import present.rpc.ClientException;

import java.io.IOException;
import java.util.TreeSet;

import static com.googlecode.objectify.ObjectifyService.ofy;

public class WhoServiceImpl implements WhoService {
  NotificationsManager nm;

  @Inject WhoServiceImpl(NotificationsManager nm) {
    this.nm = nm;
  }

  @Override public Void putDeviceToken(PutDeviceTokenRequest request) throws IOException {
    Client client = Client.current();
    if (client.token != null && client.token.equals(request.token)) {
      // Nothing to change.
      return new Void();
    }
    client.token = Strings.emptyToNull(request.token);
    // The token changed; we will need to resubscribe to topics b/c this
    // new token has never been subscribed to anything.
    client.subscribedTopics = new TreeSet<String>();
    ofy().save().entities(client);
    nm.updateSubscriptions(client);
    return new Void();
  }

  @Override public Void putLocation(PutLocationRequest request) throws IOException {
    Client client = Client.current();
<<<<<<< HEAD
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
=======
    client.latitude = request.latitude;
    client.longitude = request.longitude;
    client.countryCode = Strings.emptyToNull(request.countryCode);
    client.adminArea1 = Strings.emptyToNull(request.adminArea1);
    client.adminArea2 = Strings.emptyToNull(request.adminArea2);
    client.adminArea3 = Strings.emptyToNull(request.adminArea3);
    client.adminArea4 = Strings.emptyToNull(request.adminArea4);
    client.adminArea5 = Strings.emptyToNull(request.adminArea5);
    client.locality = Strings.emptyToNull(request.locality);
    if (request.latitude != null & request.longitude != null) {
      S2LatLng coordinates = S2LatLng.fromDegrees(request.latitude, request.longitude);
      client.location = S2CellId.fromLatLng(coordinates).id();
    } else {
      client.location = null;
    }
>>>>>>> 62c08a4... [feat] DRAFT - Subscribe clients to topics based on locations
    ofy().save().entities(client);
    nm.updateSubscriptions(client);
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
