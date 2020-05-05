#import "ExposureNotificationsPlugin.h"
#if __has_include(<exposure_notifications/exposure_notifications-Swift.h>)
#import <exposure_notifications/exposure_notifications-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "exposure_notifications-Swift.h"
#endif

@implementation ExposureNotificationsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftExposureNotificationsPlugin registerWithRegistrar:registrar];
}
@end
