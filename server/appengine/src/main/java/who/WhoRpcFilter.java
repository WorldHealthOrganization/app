package who;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import present.rpc.LoggingInterceptor;
import present.rpc.RpcFilter;
import present.rpc.RpcInterceptorChain;

/**
 * Configures RPC services.
 *
 * @author Bob Lee
 */
@Singleton public class WhoRpcFilter extends RpcFilter  {

  @Inject WhoRpcFilter(EchoServiceImpl service) {
    RpcInterceptorChain chain = new RpcInterceptorChain()
        .add(new LoggingInterceptor());

    service(EchoService.class, service, chain);

    allowHost("localhost");

    if (!Environment.isProduction()) allowAll();
  }
}
