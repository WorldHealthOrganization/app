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
    String norm = Normalizer.normalize(Strings.nullToEmpty(scope), Normalizer.Form.NFD);
    // See the following for valid characters
    // https://github.com/firebase/firebase-admin-java/blob/2cfbc3d96d0090593828f78b497ea29c09fcaae1/src/main/java/com/google/firebase/messaging/FirebaseMessaging.java#L400
    return norm.replaceAll(SCOPE_SEPARATOR + "|" + "[^a-zA-Z0-9-_.~%]", "_");
  }

  public static String createTopicName(NotificationType t, Namespace n, String ... scopes) {
    Preconditions.checkArgument(scopes.length >= 1);
    return t.toString() + SCOPE_SEPARATOR +
      n.toString() + SCOPE_SEPARATOR +
      String.join(SCOPE_SEPARATOR,
        Arrays.stream(scopes)
        .map(s -> encodeScope(s))
        .collect(Collectors.toList()));
  }

  private static ImmutableSortedSet<String> getLocationTopicNames(NotificationType t, Client client) {
    ImmutableSortedSet.Builder<String> topics = new ImmutableSortedSet.Builder<>(Ordering.natural());
    if (Strings.isNullOrEmpty(client.countryCode)) {
      return topics.build();
    }

    topics.add(createTopicName(t, Namespace.LOCATION, client.countryCode));
    if (!Strings.isNullOrEmpty(client.adminArea1)) {
      topics.add(createTopicName(t, Namespace.LOCATION,
        client.countryCode, client.adminArea1));
    }
    // Intermediate categorizations can legitimately be empty, however we would never target
    // an empty terminal categorization.
    if (!Strings.isNullOrEmpty(client.adminArea2)) {
      topics.add(createTopicName(t, Namespace.LOCATION,
        client.countryCode, client.adminArea1, client.adminArea2));
    }
    if (!Strings.isNullOrEmpty(client.adminArea3)) {
      topics.add(createTopicName(t, Namespace.LOCATION,
        client.countryCode, client.adminArea1, client.adminArea2, client.adminArea3));
    }
    if (!Strings.isNullOrEmpty(client.adminArea4)) {
      topics.add(createTopicName(t, Namespace.LOCATION,
        client.countryCode, client.adminArea1, client.adminArea2, client.adminArea3, client.adminArea4));
    }
    if (!Strings.isNullOrEmpty(client.adminArea5)) {
      topics.add(createTopicName(t, Namespace.LOCATION,
        client.countryCode, client.adminArea1, client.adminArea2, client.adminArea3, client.adminArea4, client.adminArea5));
    }
    if (!Strings.isNullOrEmpty(client.locality)) {
      topics.add(createTopicName(t, Namespace.LOCATION,
        client.countryCode, client.adminArea1, client.adminArea2, client.adminArea3, client.adminArea4, client.adminArea5, client.locality));
    }
    return topics.build();
  }

  public static ImmutableSortedSet<String> getTopicNames(Client client) {
    Preconditions.checkNotNull(client);
    // TODO: Store these user-selected types in the Client and add
    // an RPC to modify them.
    NotificationType[] types = {NotificationType.ALL};

    ImmutableSortedSet.Builder<String> topics = new ImmutableSortedSet.Builder<>(Ordering.natural());
    for (NotificationType t : types) {
      topics.addAll(getLocationTopicNames(t, client));
    }
  
    return topics.build();
  }
}
