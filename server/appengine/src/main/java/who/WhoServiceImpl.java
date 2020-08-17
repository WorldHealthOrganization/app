package who;

import com.google.common.base.Strings;
import com.google.inject.Inject;
import present.rpc.ClientException;

import java.io.IOException;
import java.util.regex.Pattern;
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

  private static final Pattern COUNTRY_CODE = Pattern.compile("^[A-Z][A-Z]$");

  @Override public Void putLocation(PutLocationRequest request) throws IOException {
    Client client = Client.current();
    // Don't even run a regex on a very long string.
    if (request.isoCountryCode == null || request.isoCountryCode.length() != 2
        || !COUNTRY_CODE.matcher(request.isoCountryCode).matches()) {
      throw new ClientException("Invalid isoCountryCode");
    }
    client.isoCountryCode = request.isoCountryCode;
    ofy().save().entities(client);
    nm.updateSubscriptions(client);
    return new Void();
  }

  // 10 mins
  private static final long STATS_TTL_SECONDS = 60 * 10;

  @Override public GetCaseStatsResponse getCaseStats(GetCaseStatsRequest request) throws IOException {
    CaseStats global = StoredCaseStats.load(JurisdictionType.GLOBAL, "");

    // TODO(brunob): Add jurisdiction-specifc stats in response.

    return new GetCaseStatsResponse.Builder()
      .globalStats(global)
      .ttl(STATS_TTL_SECONDS)
      .build();
  }
}
