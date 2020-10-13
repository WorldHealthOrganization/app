package who;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.junit.Test;
import org.mockito.ArgumentCaptor;

public class AppStoreServletTest {

  private static final String SAMPLE_ANDROID_USER_AGENT =
    "Mozilla/5.0 (Linux; U; Android 2.2) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1";
  private static final String SAMPLE_IOS_USER_AGENT =
    "Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148";

  @Test
  public void testAndroidAppStoreLink() throws Exception {
    HttpServletRequest request = mock(HttpServletRequest.class);
    HttpServletResponse response = mock(HttpServletResponse.class);

    when(request.getHeader("User-Agent")).thenReturn(SAMPLE_ANDROID_USER_AGENT);
    new AppStoreServlet().doGet(request, response);

    ArgumentCaptor<String> stringCaptor = ArgumentCaptor.forClass(String.class);
    verify(response).sendRedirect(stringCaptor.capture());

    assertEquals(
      stringCaptor.getValue(),
      AppStoreServlet.GOOGLE_PLAY_STORE_LINK
    );
  }

  @Test
  public void testAppleAppStoreLink() throws Exception {
    HttpServletRequest request = mock(HttpServletRequest.class);
    HttpServletResponse response = mock(HttpServletResponse.class);

    when(request.getHeader("User-Agent")).thenReturn(SAMPLE_IOS_USER_AGENT);
    new AppStoreServlet().doGet(request, response);

    ArgumentCaptor<String> stringCaptor = ArgumentCaptor.forClass(String.class);
    verify(response).sendRedirect(stringCaptor.capture());

    assertEquals(stringCaptor.getValue(), AppStoreServlet.APPLE_APP_STORE_LINK);
  }
}
