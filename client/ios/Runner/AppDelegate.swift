import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // Work-around for https://github.com/flutter/flutter/issues/39032
    // This is safe to remove once the fix for that is available in the SDK
    // used by this application.
    guard let controller = window?.rootViewController as? FlutterViewController else {
      fatalError("rootViewController is not type FlutterViewController")
    }
    let engine = controller.engine!
    let currentLocale = NSLocale.current
    if (currentLocale.languageCode != nil) {
      engine.localizationChannel?.invokeMethod("setLocale", arguments: [currentLocale.languageCode!, currentLocale.regionCode ?? "", currentLocale.scriptCode ?? "", currentLocale.variantCode ?? ""])
    }

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
