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
@Singleton
public class WhoRpcFilter extends RpcFilter {

  @Inject
  WhoRpcFilter(WhoServiceImpl service) {
    RpcInterceptorChain chain = new RpcInterceptorChain()
    .add(new ClientInterceptor());

    if (!Environment.isProduction()) {
      chain = chain.add(new LoggingInterceptor());
    }

    service(WhoService.class, service, chain);

    if (!Environment.isProduction()) {
      allowHost("localhost");
      allowAll();
    }
  }
}
