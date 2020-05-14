package who;

import com.google.apphosting.utils.remoteapi.RemoteApiServlet;
import com.google.inject.servlet.ServletModule;
import com.google.inject.Provides;
import com.googlecode.objectify.ObjectifyFilter;
import com.googlecode.objectify.ObjectifyService;
import javax.inject.Singleton;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import static who.ForwardingServlet.forwardTo;

/**
 * Guice and web configuration. Use this instead of web.xml.
 */
public class WhoServletModule extends ServletModule {

  private static final Logger logger = LoggerFactory.getLogger(WhoServletModule.class);

  @Provides
  Environment provideEnvironment() {
    return Environment.current();
  }

  @Override protected void configureServlets() {
    install(new FirebaseModule());
  
    // App Engine Remote API
    serve("/remote_api").with(new RemoteApiServlet());

    serve("/app").with(new AppStoreServlet());
    serve("/terms").with(forwardTo("/terms.pdf"));
    serve("/privacy").with(forwardTo("/privacy.pdf"));

    // Set up Objectify
    filter("/*").through(ObjectifyFilter.class);
    bind(ObjectifyFilter.class).in(Singleton.class);

    // Register Objectify entities
    ObjectifyService.register(Client.class);
    ObjectifyService.register(StoredCaseStats.class);

    bind(NotificationsManager.class).asEagerSingleton();

    // Internal cron jobs using Objectify but not requiring Clients.
    serve("/internal/cron/refreshCaseStats").with(new RefreshCaseStatsServlet());

    // Set up Present RPC
    filter("/*").through(WhoRpcFilter.class);
  }

}
