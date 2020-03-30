package who;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import present.rpc.ClientException;
import present.rpc.RpcInterceptor;
import present.rpc.RpcInvocation;

import static com.googlecode.objectify.ObjectifyService.ofy;

/**
 *
 */
public class ClientInterceptor implements RpcInterceptor {

  private static final String CLIENT_ID = "Who-Client-ID";
  private static final String PLATFORM = "Who-Platform";

  private static Logger logger = LoggerFactory.getLogger(ClientInterceptor.class);

  @Override public Object intercept(RpcInvocation invocation) throws Exception {
    String clientId = invocation.headers().get(CLIENT_ID);
    if (clientId == null) throw new ClientException("Missing " + CLIENT_ID + " header");

    String platformString = invocation.headers().get(PLATFORM);
    Platform platform;
    switch (platformString.toUpperCase()) {
      case "IOS":
        platform = Platform.IOS;
        break;
      case "ANDROID":
        platform = Platform.ANDROID;
        break;
      case "WEB":
        platform = Platform.WEB;
        break;
      default:
        throw new ClientException("Missing " + PLATFORM + " header.");
    }

    Client client = Client.getOrCreate(clientId, platform);
    Client.currentClient.set(client);
    if (!Environment.isProduction()) logger.info(CLIENT_ID + ": " + client.uuid);
    try {
      return invocation.proceed();
    } finally {
      Client.currentClient.remove();
    }
  }
}
