package who;

import com.google.inject.Singleton;
import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

@Singleton
public class ContentCachingFilter implements Filter {

  public void doFilter(ServletRequest request, ServletResponse response,
                        FilterChain chain) throws IOException, ServletException {
    HttpServletResponse resp = (HttpServletResponse) response;
    resp.setHeader("Cache-Control", "max-age=600");
    chain.doFilter(request, response);
  }

  public void init(FilterConfig filterConfig) throws ServletException { }

  public void destroy() { }

}
