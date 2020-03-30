package who;

import com.google.apphosting.utils.remoteapi.RemoteApiServlet;
import com.google.inject.servlet.ServletModule;
import com.googlecode.objectify.ObjectifyFilter;
import com.googlecode.objectify.ObjectifyService;
import javax.inject.Singleton;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Guice and web configuration. Use this instead of web.xml.
 */
public class WhoServletModule extends ServletModule {

  private static final Logger logger = LoggerFactory.getLogger(WhoServletModule.class);

  @Override protected void configureServlets() {
    // App Engine Remote API
    serve("/remote_api").with(new RemoteApiServlet());

    // Set up Objectify
    filter("/*").through(ObjectifyFilter.class);
    bind(ObjectifyFilter.class).in(Singleton.class);

    // Register Objectify entities
    ObjectifyService.register(Client.class);

    // Set up Present RPC
    filter("/*").through(WhoRpcFilter.class);
  }
}
