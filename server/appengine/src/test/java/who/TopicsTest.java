package who;

import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class TopicsTest {

  @Test
  public void testCreateTopicName() throws Exception {
    System.err.println(Topics.createTopicName(Topics.NotificationType.ALL, Topics.Namespace.LOCATION));
    assertEquals("ALL~LOCATION", Topics.createTopicName(Topics.NotificationType.ALL, Topics.Namespace.LOCATION));
    assertEquals("ALL~LOCATION~US", Topics.createTopicName(Topics.NotificationType.ALL, Topics.Namespace.LOCATION, "US"));
  }

  @Test
  public void testTopicNames() throws Exception {
    Client c = new Client();
    c.isoCountryCode = "US";
    System.err.println(Topics.getTopicNames(c));
  }
}
