#import "GetProxyPlugin.h"

@implementation GetProxyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"get_proxy"
            binaryMessenger:[registrar messenger]];
  GetProxyPlugin* instance = [[GetProxyPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getProxy" isEqualToString:call.method]) {
    result([self getProxy]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (NSString*) getProxy {
    @try {
      CFDictionaryRef dicRef = CFNetworkCopySystemProxySettings();
      const CFStringRef proxyCFstr = (const CFStringRef)CFDictionaryGetValue(dicRef, (const void*)kCFNetworkProxiesHTTPProxy);
      if (proxyCFstr == nil) {
        return @"";
      }
      const CFNumberRef portCFnum = (const CFNumberRef)CFDictionaryGetValue(dicRef, (const void*)kCFNetworkProxiesHTTPPort);
      char buffer[4096];
      memset(buffer, 0, 4096);
      SInt32 port;
      if (CFStringGetCString(proxyCFstr, buffer, 4096, kCFStringEncodingUTF8))
      {
        if (CFNumberGetValue(portCFnum, kCFNumberSInt32Type, &port))
        {
          return [NSString stringWithFormat: @"PROXY %s:%d", buffer, port];
        } else {
          return [NSString stringWithFormat: @"PROXY %s", buffer];
        }
      }
      return @"";
    }

    @catch (id ue) {
      return @"";
    }
}


@end
