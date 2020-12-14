package who;

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.google.common.base.Strings;
import com.google.inject.Inject;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.TreeSet;
import java.util.regex.Pattern;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import present.rpc.ClientException;

public class WhoServiceImpl implements WhoService {

  NotificationsManager nm;
  private static final Logger logger = LoggerFactory.getLogger(
    WhoServiceImpl.class
  );

  @Inject
  WhoServiceImpl(NotificationsManager nm) {
    this.nm = nm;
  }

  // TODO: Delete this method once all clients are moved to putClientSettings.
  @Override
  public Void putDeviceToken(PutDeviceTokenRequest request) throws IOException {
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

  private static final Pattern COUNTRY_CODE = Pattern.compile("^[A-Z][A-Z]$");

  // TODO: Delete this method once all clients are moved to putClientSettings.
  @Override
  public Void putLocation(PutLocationRequest request) throws IOException {
    Client client = Client.current();
    // Don't even run a regex on a very long string.
    if (
      request.isoCountryCode == null ||
      request.isoCountryCode.length() != 2 ||
      !COUNTRY_CODE.matcher(request.isoCountryCode).matches()
    ) {
      throw new ClientException("Invalid isoCountryCode");
    }
    client.isoCountryCode = request.isoCountryCode;
    ofy().save().entities(client);
    nm.updateSubscriptions(client);
    return new Void();
  }

  @Override
  public Void putClientSettings(PutClientSettingsRequest request)
    throws IOException {
    // TODO: Consider doing this in some form of datastore transaction. The trick being that the firebase and datastore may get out of sync...
    Client client = Client.current();

    // The client may not yet have set a country code, or may somehow have removed it.
    // The server can handle this scenario, so the information provided will be recorded.
    if (
      request.isoCountryCode == null || request.isoCountryCode.length() == 0
    ) {
      client.isoCountryCode = "";
    } else {
      // Don't even run a regex on a very long string.
      if (
        request.isoCountryCode.length() != 2 ||
        !COUNTRY_CODE.matcher(request.isoCountryCode).matches()
      ) {
        throw new ClientException("Invalid isoCountryCode");
      }
      client.isoCountryCode = request.isoCountryCode;
    }
    client.token = Strings.emptyToNull(request.token);

    ofy().save().entities(client);
    nm.updateSubscriptions(client);
    return new Void();
  }

  // 10 mins
  private static final long STATS_TTL_SECONDS = 60 * 10;

  // 36 hrs
  private static final long STATS_TOO_OLD_MSEC = 1000 * 60 * 60 * 36;

  @Override
  public GetCaseStatsResponse getCaseStats(GetCaseStatsRequest request)
    throws IOException {
    List<CaseStats> stats = new ArrayList<>();
    for (JurisdictionId j : request.jurisdictions) {
      if (j.code != null && j.code.length() > 2) {
        throw new ClientException("Invalid jurisdiction code");
      }
      CaseStats data = StoredCaseStats.load(
        j.jurisdictionType,
        j.code == null ? "" : j.code
      );
      if (data != null) {
        if (
          data.lastUpdated < System.currentTimeMillis() - STATS_TOO_OLD_MSEC
        ) {
          // Log to watch on monitoring, but we'll still return results to the user.
          logger.error(
            "Case stats are too old - last updated at msec epoch: " +
            data.lastUpdated
          );
        }
        stats.add(data);
      } else {
        stats.add(new CaseStats.Builder().lastUpdated(0L).build());
      }
    }

    return new GetCaseStatsResponse.Builder()
      .jurisdictionStats(stats)
      .ttl(STATS_TTL_SECONDS)
      .build();
  }
}
