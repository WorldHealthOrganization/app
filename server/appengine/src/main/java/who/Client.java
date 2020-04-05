package who;

import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.condition.IfNotNull;

import static com.googlecode.objectify.ObjectifyService.ofy;

/**
 * Represents an app client.
 */
@Entity @Cache public class Client {

  @Id String uuid;

  /** Device token for notifications. */
  public String token;

  public Platform platform;

  /** S2 leaf cell ID for last known location. See S2CellId. */
  @Index(IfNotNull.class) public Long location;
  public Double latitude;
  public Double longitude;

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
