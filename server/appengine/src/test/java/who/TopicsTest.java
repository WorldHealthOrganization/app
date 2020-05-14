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
}
