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

  @Override protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws IOException {
    if (request.getHeader("User-Agent").toLowerCase().contains("android")) {
      response.sendRedirect("https://play.google.com/store/apps/details?id=org.who.WHOMyHealth");
    } else {
      response.sendRedirect("https://apps.apple.com/app/id1503458183");
    }
  }
}
