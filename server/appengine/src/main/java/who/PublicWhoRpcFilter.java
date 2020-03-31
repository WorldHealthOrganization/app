package who;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import present.rpc.LoggingInterceptor;
import present.rpc.RpcFilter;
import present.rpc.RpcInterceptorChain;

/**
 * Configures RPC services for publicly-cacheable APIs.
 */
@Singleton public class PublicWhoRpcFilter extends RpcFilter  {

  @Inject PublicWhoRpcFilter(PublicWhoServiceImpl service) {
    RpcInterceptorChain chain = new RpcInterceptorChain()
        .add(new PublicRpcInterceptor())
        .add(new LoggingInterceptor());

    service(PublicWhoService.class, service, chain);

    if (!Environment.isProduction()) {
      allowHost("localhost");
      allowAll();
    }
  }
}
