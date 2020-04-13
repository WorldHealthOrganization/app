package who;

import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.condition.IfNotNull;

import java.util.SortedSet;
import java.util.TreeSet;

import static com.googlecode.objectify.ObjectifyService.ofy;

/**
 * Represents an app client.
 */
@Entity @Cache public class Client {

  @Id String uuid;

  /** Device token for notifications. */
  public String token;

  public Platform platform;


  /** S2 cell ID for last known location. See S2CellId. */
  @Index(IfNotNull.class) public Long location;
  // No locations of greater level (specificity) than this will be
  // stored and indexed.  This prevents us from storing precise
  // locations and protects the database index size.
  // See: https://s2geometry.io/resources/s2cell_statistics.html
  public static final int MAX_S2_CELL_LEVEL = 9;

  // Lat/lng representative of the cell, not neccessarily
  // of the device.
  public Double latitude;
  public Double longitude;

  // Store denormalized location info.
  @Index(IfNotNull.class) public String countryCode;
  @Index(IfNotNull.class) public String adminArea1;
  @Index(IfNotNull.class) public String adminArea2;
  @Index(IfNotNull.class) public String adminArea3;
  @Index(IfNotNull.class) public String adminArea4;
  @Index(IfNotNull.class) public String adminArea5;
  @Index(IfNotNull.class) public String locality;

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
