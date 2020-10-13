package who;

import static com.googlecode.objectify.ObjectifyService.ofy;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import present.engine.Uuids;
import present.rpc.ClientException;
import present.rpc.RpcInterceptor;
import present.rpc.RpcInvocation;

/**
 * Looks up Client based on HTTP headers.
 */
public class ClientInterceptor implements RpcInterceptor {

  private static final String CLIENT_ID = "Who-Client-ID";
  private static final String PLATFORM = "Who-Platform";

  private static Logger logger = LoggerFactory.getLogger(
    ClientInterceptor.class
  );

  @Override
  public Object intercept(RpcInvocation invocation) throws Exception {
    String clientId = invocation.headers().get(CLIENT_ID);
    if (clientId == null) throw new ClientException(
      "Missing " + CLIENT_ID + " header"
    );
    clientId = clientId.toLowerCase();
    if (!Uuids.isValid(clientId)) throw new ClientException(
      CLIENT_ID + " header must be a valid UUID."
    );

    String platformString = invocation.headers().get(PLATFORM);
    if (platformString == null) throw new ClientException(
      "Missing " + PLATFORM + " header"
    );
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
        throw new ClientException("Unsupported " + PLATFORM + " header");
    }

    Client client = Client.getOrCreate(clientId, platform);
    Client.currentClient.set(client);
    if (!Environment.isProduction()) logger.info(
      CLIENT_ID + ": " + client.uuid
    );
    try {
      return invocation.proceed();
    } finally {
      Client.currentClient.remove();
    }
  }
}
