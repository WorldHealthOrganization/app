package who;

import com.palantir.roboslack.api.MessageRequest;
import com.palantir.roboslack.webhook.SlackWebHookService;
import com.palantir.roboslack.webhook.api.model.WebHookToken;
import com.palantir.roboslack.webhook.api.model.response.ResponseCode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Posts messages to Slack.
 *
 * Test message formatting here: https://api.slack.com/docs/messages/builder?msg=%7B%22text%22%3A%20%22%22%7D
 */
public class Slack {

  private static final Logger logger = LoggerFactory.getLogger(Slack.class);

  public enum Channel {
    // Create new hooks here: https://api.slack.com/apps/AJR8X8U2V/incoming-webhooks

    TEST("INSERT_TOKEN_HERE");

    private final WebHookToken token;

    Channel(String token) {
      this.token = WebHookToken.fromString(token);
    }
  }

  public static void post(Channel channel, MessageRequest.Builder message) {
    message.username("WHO App Server");
    if (!Environment.isProduction()) channel = Channel.TEST;
    SlackWebHookService.with(channel.token).sendMessageAsync(message.build(),
        new Callback<ResponseCode>() {
          @Override
          public void onResponse(Call<ResponseCode> call, Response<ResponseCode> response) {
            logger.info("Response from Slack: " + response);
          }

          @Override public void onFailure(Call<ResponseCode> call, Throwable t) {
            logger.warn("Error calling Slack.", t);
          }
        });
  }

  public static String link(String text, String url) {
    return "<" + url + "|" + text + ">";
  }

  public static String bold(String text) {
    return "*" + text + "*";
  }
}
