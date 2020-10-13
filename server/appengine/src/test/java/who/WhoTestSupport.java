package who;

import com.google.appengine.tools.development.testing.LocalDatastoreServiceTestConfig;
import com.google.appengine.tools.development.testing.LocalServiceTestHelper;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.util.Closeable;
import org.junit.After;
import org.junit.Before;

public abstract class WhoTestSupport {

  protected final LocalServiceTestHelper helper = new LocalServiceTestHelper(
    new LocalDatastoreServiceTestConfig().setApplyAllHighRepJobPolicy()
  );

  private Closeable objectify;

  @Before
  public void setup() {
    helper.setUp();
    objectify = ObjectifyService.begin();
  }

  @After
  public void tearDown() {
    objectify.close();
    helper.tearDown();
  }
}
