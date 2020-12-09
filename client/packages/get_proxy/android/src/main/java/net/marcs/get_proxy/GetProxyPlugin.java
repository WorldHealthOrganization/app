package net.marcs.get_proxy;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.ProxyInfo;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** GetProxyPlugin */
public class GetProxyPlugin implements FlutterPlugin, MethodCallHandler {

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private ConnectivityManager manager;

  @Override
  public void onAttachedToEngine(
    @NonNull FlutterPluginBinding flutterPluginBinding
  ) {
    channel =
      new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "get_proxy");
    channel.setMethodCallHandler(this);
    manager =
      (ConnectivityManager) flutterPluginBinding
        .getApplicationContext()
        .getSystemService(Context.CONNECTIVITY_SERVICE);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getProxy")) {
      if (manager != null) {
        ProxyInfo proxyInfo = manager.getDefaultProxy();
        if (proxyInfo != null) {
          String proxyHost = proxyInfo.getHost();
          String proxyPort = String.valueOf(proxyInfo.getPort());
          if (proxyHost != null && proxyPort != null) {
            result.success("PROXY " + proxyHost + ":" + proxyPort);
          }
        }
      }
      result.success("");
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
