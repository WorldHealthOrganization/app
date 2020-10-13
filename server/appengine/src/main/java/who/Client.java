package who;

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.condition.IfNotNull;
import java.util.SortedSet;
import java.util.TreeSet;

/**
 * Represents an app client.
 */
@Entity
@Cache
public class Client {

  @Id
  String uuid;

  /** Device token for notifications. */
  public String token;

  public Platform platform;

  @Index(IfNotNull.class)
  public String isoCountryCode;

  // No FCM API exists to list a token's topics, so we
  // must track them explicitly and sub and unsub from
  // the appropriate topics as the client changes.
  public SortedSet<String> subscribedTopics = new TreeSet<>();

  public static Client getOrCreate(String uuid, Platform platform) {
    Client client = ofy().load().type(Client.class).id(uuid).now();
    if (client != null) return client;

    client = new Client();
    client.uuid = uuid;
    client.platform = platform;

    ofy().save().entities(client).now();

    return client;
  }

  static final ThreadLocal<Client> currentClient = new ThreadLocal<>();

  public static Client current() {
    return currentClient.get();
  }
}
