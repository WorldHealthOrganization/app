package who;

import java.io.IOException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Redirects to appropriate app store.
 *
 * @author Bob Lee
 */
public class AppStoreServlet extends HttpServlet {

  static final String GOOGLE_PLAY_STORE_LINK =
    "https://play.google.com/store/apps/details?id=org.who.WHOMyHealth";
  static final String APPLE_APP_STORE_LINK =
    "https://apps.apple.com/app/id1503458183";

  @Override
  protected void doGet(
    HttpServletRequest request,
    HttpServletResponse response
  ) throws IOException {
    if (request.getHeader("User-Agent").toLowerCase().contains("android")) {
      response.sendRedirect(GOOGLE_PLAY_STORE_LINK);
    } else {
      response.sendRedirect(APPLE_APP_STORE_LINK);
    }
  }
}
