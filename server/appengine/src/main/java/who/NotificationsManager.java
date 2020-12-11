package who;

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.google.common.base.Preconditions;
import com.google.common.base.Strings;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.TopicManagementResponse;
import com.google.inject.Inject;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.SortedSet;
import java.util.stream.Collectors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class NotificationsManager {

  FirebaseMessaging fcm;

  private static Logger logger = LoggerFactory.getLogger(
    NotificationsManager.class
  );

  @Inject
  public NotificationsManager(FirebaseMessaging fcm, Environment env) {
    this.fcm = fcm;
  }

  public void updateSubscriptions(Client client) throws IOException {
    Preconditions.checkNotNull(client);
    if (client.token == null) {
      return;
    }
    SortedSet<String> finalTopics = Topics.getTopicNames(client);
    Set<String> topicsToRemove = Sets
      .difference(client.subscribedTopics, finalTopics)
      .immutableCopy();
    // We (re-)register for *all* current topics when they change.
    // This ensures that a client will eventually correct their subscriptions if a prior update
    // fails.
    Set<String> topicsToAdd = finalTopics;
    List<String> theToken = ImmutableList.of(client.token);

    try {
      // We cannot atomically change subscription sets.  Better to have more subscriptions
      // as the user changes properties rather than fewer, so subscribe first.
      for (String topic : topicsToAdd) {
        TopicManagementResponse resp = fcm.subscribeToTopic(theToken, topic);
        if (resp.getSuccessCount() == 1) {
          if (!Environment.isProduction()) logger.info(
            "SUCCESS - Subscribed " + client.token + " to topic " + topic
          );
          client.subscribedTopics.add(topic);
          // If something goes wrong we'll still save the partial update.
          ofy().defer().save().entity(client);
        } else {
          if (!Environment.isProduction()) {
            logger.info(
              "FAILED - Subscribed " + client.token + " to topic " + topic
            );
            List<TopicManagementResponse.Error> errors = resp.getErrors();
            for (TopicManagementResponse.Error error : errors) {
              logger.info("FAILED - Reason - " + error);
            }
          }
        }
      }

      for (String topic : topicsToRemove) {
        TopicManagementResponse resp = fcm.unsubscribeFromTopic(
          theToken,
          topic
        );
        if (resp.getSuccessCount() == 1) {
          if (!Environment.isProduction()) logger.info(
            "SUCCESS - Unsubscribed " + client.token + " from topic " + topic
          );
          client.subscribedTopics.remove(topic);
          // If something goes wrong we'll still save the partial update.
          ofy().defer().save().entity(client);
        } else {
          if (!Environment.isProduction()) logger.info(
            "FAILED - Unsubscribed " + client.token + " from topic " + topic
          );
        }
      }
    } catch (FirebaseMessagingException fme) {
      throw new IOException(fme);
    }

    ofy().save().entity(client).now();
  }
}
