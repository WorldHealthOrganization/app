package who;

import com.google.common.base.Preconditions;
import com.google.common.base.Strings;
import com.google.common.collect.ImmutableSortedSet;
import com.google.common.collect.Ordering;
import java.text.Normalizer;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class Topics {

  public enum Namespace {
    LOCATION,
  }

  // In the future, users may only want to see specific kinds
  // of notifications like alert vs general news, etc.
  public enum NotificationType {
    ALL,
  }

  public static final String SCOPE_SEPARATOR = "~";

  static String encodeScope(String scope) {
    // An empty string is a valid scope.
    // We want accents to be "reduced" to their ascii counterparts.
    String norm = Normalizer.normalize(
      Strings.nullToEmpty(scope),
      Normalizer.Form.NFD
    );
    // See the following for valid characters
    // https://github.com/firebase/firebase-admin-java/blob/2cfbc3d96d0090593828f78b497ea29c09fcaae1/src/main/java/com/google/firebase/messaging/FirebaseMessaging.java#L400
    return norm.replaceAll(SCOPE_SEPARATOR + "|" + "[^a-zA-Z0-9-_.~%]", "_");
  }

  public static String createTopicName(
    NotificationType t,
    Namespace n,
    String... scopes
  ) {
    return (
      t.toString() +
      SCOPE_SEPARATOR +
      n.toString() +
      (
        scopes.length > 0
          ? SCOPE_SEPARATOR +
          String.join(
            SCOPE_SEPARATOR,
            Arrays
              .stream(scopes)
              .map(s -> encodeScope(s))
              .collect(Collectors.toList())
          )
          : ""
      )
    );
  }

  private static ImmutableSortedSet<String> getLocationTopicNames(
    NotificationType t,
    Client client
  ) {
    ImmutableSortedSet.Builder<String> topics = new ImmutableSortedSet.Builder<>(
      Ordering.natural()
    );
    // Global
    topics.add(createTopicName(t, Namespace.LOCATION));

    if (!Strings.isNullOrEmpty(client.isoCountryCode)) {
      // Per-country
      topics.add(createTopicName(t, Namespace.LOCATION, client.isoCountryCode));
    }

    return topics.build();
  }

  public static ImmutableSortedSet<String> getTopicNames(Client client) {
    Preconditions.checkNotNull(client);
    // TODO: Store these user-selected types in the Client and add
    // an RPC to modify them.  Some day users may want to register
    // only for news, testing centers, etc. and we must properly
    // namespace topic names now to support that in the future.
    NotificationType[] types = { NotificationType.ALL };

    ImmutableSortedSet.Builder<String> topics = new ImmutableSortedSet.Builder<>(
      Ordering.natural()
    );
    for (NotificationType t : types) {
      topics.addAll(getLocationTopicNames(t, client));
    }

    return topics.build();
  }
}
