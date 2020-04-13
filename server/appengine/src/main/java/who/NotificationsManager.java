package who;

import com.google.common.base.Preconditions;
import com.google.common.base.Strings;
import com.google.common.collect.Sets;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.Lists;
import com.google.inject.Inject;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.TopicManagementResponse;
import java.io.IOException;

import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.SortedSet;
import java.util.stream.Collectors;

import static com.googlecode.objectify.ObjectifyService.ofy;

public class NotificationsManager {
  FirebaseMessaging fcm;

  @Inject
  public NotificationsManager(FirebaseMessaging fcm) {
    this.fcm = fcm;
  }

  public void updateSubscriptions(Client client) throws IOException {
    Preconditions.checkNotNull(client);
    if (client.token == null) {
      return;
    }
    SortedSet<String> finalTopics = Topics.getTopicNames(client);
    Set<String> topicsToRemove = Sets.difference(client.subscribedTopics, finalTopics).immutableCopy();
    Set<String> topicsToAdd = Sets.difference(finalTopics, client.subscribedTopics).immutableCopy();
    List<String> theToken = ImmutableList.of(client.token);

    try {
      // We cannot atomically change subscription sets.  Better to have more subscriptions
      // as the user moves locations rather than fewer, so subscribe first.
      for (String topic : topicsToAdd) {
        TopicManagementResponse resp = fcm.subscribeToTopic(theToken, topic);
        if (resp.getSuccessCount() == 1) {
          client.subscribedTopics.add(topic);
          // If something goes wrong we'll still save the partial update.
          ofy().defer().save().entity(client);
        }
      }

      for (String topic : topicsToRemove) {
        TopicManagementResponse resp = fcm.unsubscribeFromTopic(theToken, topic);
        if (resp.getSuccessCount() == 1) {
          client.subscribedTopics.remove(topic);
          // If something goes wrong we'll still save the partial update.
          ofy().defer().save().entity(client);
        }
      }
    } catch (FirebaseMessagingException fme) {
      throw new IOException(fme);
    }

    ofy().save().entity(client).now();
  }
}
