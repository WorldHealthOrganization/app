package who;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ForwardingServlet extends HttpServlet {

  private final String path;

  private ForwardingServlet(String path) {
    this.path = path;
  }

  @Override
  protected void doGet(
    HttpServletRequest request,
    HttpServletResponse response
  ) throws ServletException, IOException {
    request.getRequestDispatcher(path).forward(request, response);
  }

  public static HttpServlet forwardTo(String path) {
    return new ForwardingServlet(path);
  }
}
