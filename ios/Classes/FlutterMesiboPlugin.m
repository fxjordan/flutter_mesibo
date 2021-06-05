#import "FlutterMesiboPlugin.h"
#if __has_include(<flutter_mesibo/flutter_mesibo-Swift.h>)
#import <flutter_mesibo/flutter_mesibo-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_mesibo-Swift.h"
#endif

@implementation FlutterMesiboPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterMesiboPlugin registerWithRegistrar:registrar];
}
@end
