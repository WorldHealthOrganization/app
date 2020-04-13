package who;

import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class TopicsTest {

  @Test
  public void testCreateTopicName() throws Exception {
    assertEquals(Topics.createTopicName(Topics.NotificationType.ALL, Topics.Namespace.LOCATION, "US"), "ALL~LOCATION~US");
    assertEquals(Topics.createTopicName(Topics.NotificationType.ALL, Topics.Namespace.LOCATION, "US", ""), "ALL~LOCATION~US~");
    assertEquals(Topics.createTopicName(Topics.NotificationType.ALL, Topics.Namespace.LOCATION, "", "CA"), "ALL~LOCATION~~CA");
    assertEquals(Topics.createTopicName(Topics.NotificationType.ALL, Topics.Namespace.LOCATION, "US", "CA"), "ALL~LOCATION~US~CA");
    assertEquals(Topics.createTopicName(Topics.NotificationType.ALL, Topics.Namespace.LOCATION, "US", "CA", null, null, null, null, "San José"), "ALL~LOCATION~US~CA~~~~~San_Jose_");
    assertEquals(Topics.createTopicName(Topics.NotificationType.ALL, Topics.Namespace.LOCATION, "U/S", "CA"), "ALL~LOCATION~U_S~CA");
  }

  @Test
  public void testTopicNames() throws Exception {
    Client c = new Client();
    c.countryCode = "US";
    c.adminArea1 = "CA";
    c.adminArea2 = "San Francisco County";
    c.locality = "San Francisco";
    System.err.println(Topics.getTopicNames(c));
  }
}
