package who;

public class EchoServiceImpl implements EchoService {

  @Override public EchoMessage echo(EchoMessage request) {
    return request;
  }
}
