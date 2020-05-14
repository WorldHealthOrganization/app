package who;

import com.google.apphosting.utils.remoteapi.RemoteApiServlet;
import com.google.inject.servlet.ServletModule;
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

  @Override protected void configureServlets() {
    // App Engine Remote API
    serve("/remote_api").with(new RemoteApiServlet());

    serve("/app").with(new AppStoreServlet());
    serve("/terms").with(forwardTo("/terms.pdf"));
    serve("/privacy").with(forwardTo("/privacy.pdf"));

    // TODO: Make this much better.
    final String[] bundles = new String[]{"news_index", "get_the_facts", "home_index", "learn_index", "protect_yourself", "symptom_checker", "travel_advice", "your_questions_answered"};
    for (final String bundle : bundles) 
    {
      for (int i = 0; i < 26; i++) {
        for (int j = 0; j < 26; j++) {
          String countryCode = "" + (char)((int)('A') + i) + (char)((int)('A') + j);
          // Wildcards don't work for the country.
          serve("/content/bundles/" + bundle + ".en_" + countryCode + ".yaml").with(forwardTo("/content/bundles/" + bundle + ".en.yaml"));
        }
      }
    }

    // Set up Objectify
    filter("/*").through(ObjectifyFilter.class);
    bind(ObjectifyFilter.class).in(Singleton.class);

    // Register Objectify entities
    ObjectifyService.register(Client.class);
    ObjectifyService.register(StoredCaseStats.class);

    // Internal cron jobs using Objectify but not requiring Clients.
    serve("/internal/cron/refreshCaseStats").with(new RefreshCaseStatsServlet());

    // Set up Present RPC
    filter("/*").through(WhoRpcFilter.class);
  }
}
