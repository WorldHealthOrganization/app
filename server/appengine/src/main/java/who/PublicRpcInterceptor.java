package who;

import present.rpc.ClientException;
import present.rpc.RpcInterceptor;
import present.rpc.RpcInvocation;

/**
 * For publicly-cacheable RPCs.
 */
public class PublicRpcInterceptor implements RpcInterceptor {

  @Override public Object intercept(RpcInvocation invocation) throws Exception {
    String clientId = invocation.headers().get(ClientInterceptor.CLIENT_ID);
    if (clientId != null) {
      throw new ClientException(
        "Received " + ClientInterceptor.CLIENT_ID + " header on publicly-cacheable API");
    }
    return invocation.proceed();
  }
}
