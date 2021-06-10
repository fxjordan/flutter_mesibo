// Autogenerated from Pigeon (v0.1.23), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import "mesibo_binding.h"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSDictionary<NSString*, id>* wrapResult(NSDictionary *result, FlutterError *error) {
  NSDictionary *errorDict = (NSDictionary *)[NSNull null];
  if (error) {
    errorDict = @{
        @"code": (error.code ? error.code : [NSNull null]),
        @"message": (error.message ? error.message : [NSNull null]),
        @"details": (error.details ? error.details : [NSNull null]),
        };
  }
  return @{
      @"result": (result ? result : [NSNull null]),
      @"error": errorDict,
      };
}

@interface MSBOSetAccessTokenCommand ()
+(MSBOSetAccessTokenCommand*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end
@interface MSBOChatHistoryResult ()
+(MSBOChatHistoryResult*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end
@interface MSBOLoadChatHistoryCommand ()
+(MSBOLoadChatHistoryCommand*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end
@interface MSBOChatSummaryResult ()
+(MSBOChatSummaryResult*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end
@interface MSBOLoadChatSummaryCommand ()
+(MSBOLoadChatSummaryCommand*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end
@interface MSBOSendMessageResult ()
+(MSBOSendMessageResult*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end
@interface MSBOSendMessageCommand ()
+(MSBOSendMessageCommand*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end
@interface MSBOMessageParams ()
+(MSBOMessageParams*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end
@interface MSBOUserProfile ()
+(MSBOUserProfile*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end
@interface MSBOConnectionStatus ()
+(MSBOConnectionStatus*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end
@interface MSBOMesiboMessage ()
+(MSBOMesiboMessage*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end

@implementation MSBOSetAccessTokenCommand
+(MSBOSetAccessTokenCommand*)fromMap:(NSDictionary*)dict {
  MSBOSetAccessTokenCommand* result = [[MSBOSetAccessTokenCommand alloc] init];
  result.accessToken = dict[@"accessToken"];
  if ((NSNull *)result.accessToken == [NSNull null]) {
    result.accessToken = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.accessToken ? self.accessToken : [NSNull null]), @"accessToken", nil];
}
@end

@implementation MSBOChatHistoryResult
+(MSBOChatHistoryResult*)fromMap:(NSDictionary*)dict {
  MSBOChatHistoryResult* result = [[MSBOChatHistoryResult alloc] init];
  result.readCount = dict[@"readCount"];
  if ((NSNull *)result.readCount == [NSNull null]) {
    result.readCount = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.readCount ? self.readCount : [NSNull null]), @"readCount", nil];
}
@end

@implementation MSBOLoadChatHistoryCommand
+(MSBOLoadChatHistoryCommand*)fromMap:(NSDictionary*)dict {
  MSBOLoadChatHistoryCommand* result = [[MSBOLoadChatHistoryCommand alloc] init];
  result.peerAddress = dict[@"peerAddress"];
  if ((NSNull *)result.peerAddress == [NSNull null]) {
    result.peerAddress = nil;
  }
  result.count = dict[@"count"];
  if ((NSNull *)result.count == [NSNull null]) {
    result.count = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.peerAddress ? self.peerAddress : [NSNull null]), @"peerAddress", (self.count ? self.count : [NSNull null]), @"count", nil];
}
@end

@implementation MSBOChatSummaryResult
+(MSBOChatSummaryResult*)fromMap:(NSDictionary*)dict {
  MSBOChatSummaryResult* result = [[MSBOChatSummaryResult alloc] init];
  result.readCount = dict[@"readCount"];
  if ((NSNull *)result.readCount == [NSNull null]) {
    result.readCount = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.readCount ? self.readCount : [NSNull null]), @"readCount", nil];
}
@end

@implementation MSBOLoadChatSummaryCommand
+(MSBOLoadChatSummaryCommand*)fromMap:(NSDictionary*)dict {
  MSBOLoadChatSummaryCommand* result = [[MSBOLoadChatSummaryCommand alloc] init];
  result.count = dict[@"count"];
  if ((NSNull *)result.count == [NSNull null]) {
    result.count = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.count ? self.count : [NSNull null]), @"count", nil];
}
@end

@implementation MSBOSendMessageResult
+(MSBOSendMessageResult*)fromMap:(NSDictionary*)dict {
  MSBOSendMessageResult* result = [[MSBOSendMessageResult alloc] init];
  result.result = dict[@"result"];
  if ((NSNull *)result.result == [NSNull null]) {
    result.result = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.result ? self.result : [NSNull null]), @"result", nil];
}
@end

@implementation MSBOSendMessageCommand
+(MSBOSendMessageCommand*)fromMap:(NSDictionary*)dict {
  MSBOSendMessageCommand* result = [[MSBOSendMessageCommand alloc] init];
  result.params = [MSBOMessageParams fromMap:dict[@"params"]];
  if ((NSNull *)result.params == [NSNull null]) {
    result.params = nil;
  }
  result.mid = dict[@"mid"];
  if ((NSNull *)result.mid == [NSNull null]) {
    result.mid = nil;
  }
  result.data = dict[@"data"];
  if ((NSNull *)result.data == [NSNull null]) {
    result.data = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.params ? [self.params toMap] : [NSNull null]), @"params", (self.mid ? self.mid : [NSNull null]), @"mid", (self.data ? self.data : [NSNull null]), @"data", nil];
}
@end

@implementation MSBOMessageParams
+(MSBOMessageParams*)fromMap:(NSDictionary*)dict {
  MSBOMessageParams* result = [[MSBOMessageParams alloc] init];
  result.mid = dict[@"mid"];
  if ((NSNull *)result.mid == [NSNull null]) {
    result.mid = nil;
  }
  result.groupId = dict[@"groupId"];
  if ((NSNull *)result.groupId == [NSNull null]) {
    result.groupId = nil;
  }
  result.ts = dict[@"ts"];
  if ((NSNull *)result.ts == [NSNull null]) {
    result.ts = nil;
  }
  result.channel = dict[@"channel"];
  if ((NSNull *)result.channel == [NSNull null]) {
    result.channel = nil;
  }
  result.type = dict[@"type"];
  if ((NSNull *)result.type == [NSNull null]) {
    result.type = nil;
  }
  result.expiry = dict[@"expiry"];
  if ((NSNull *)result.expiry == [NSNull null]) {
    result.expiry = nil;
  }
  result.flag = dict[@"flag"];
  if ((NSNull *)result.flag == [NSNull null]) {
    result.flag = nil;
  }
  result.userFlags = dict[@"userFlags"];
  if ((NSNull *)result.userFlags == [NSNull null]) {
    result.userFlags = nil;
  }
  result.duration = dict[@"duration"];
  if ((NSNull *)result.duration == [NSNull null]) {
    result.duration = nil;
  }
  result.status = dict[@"status"];
  if ((NSNull *)result.status == [NSNull null]) {
    result.status = nil;
  }
  result.origin = dict[@"origin"];
  if ((NSNull *)result.origin == [NSNull null]) {
    result.origin = nil;
  }
  result.peer = dict[@"peer"];
  if ((NSNull *)result.peer == [NSNull null]) {
    result.peer = nil;
  }
  result.encKey = dict[@"encKey"];
  if ((NSNull *)result.encKey == [NSNull null]) {
    result.encKey = nil;
  }
  result.profile = [MSBOUserProfile fromMap:dict[@"profile"]];
  if ((NSNull *)result.profile == [NSNull null]) {
    result.profile = nil;
  }
  result.groupProfile = [MSBOUserProfile fromMap:dict[@"groupProfile"]];
  if ((NSNull *)result.groupProfile == [NSNull null]) {
    result.groupProfile = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.mid ? self.mid : [NSNull null]), @"mid", (self.groupId ? self.groupId : [NSNull null]), @"groupId", (self.ts ? self.ts : [NSNull null]), @"ts", (self.channel ? self.channel : [NSNull null]), @"channel", (self.type ? self.type : [NSNull null]), @"type", (self.expiry ? self.expiry : [NSNull null]), @"expiry", (self.flag ? self.flag : [NSNull null]), @"flag", (self.userFlags ? self.userFlags : [NSNull null]), @"userFlags", (self.duration ? self.duration : [NSNull null]), @"duration", (self.status ? self.status : [NSNull null]), @"status", (self.origin ? self.origin : [NSNull null]), @"origin", (self.peer ? self.peer : [NSNull null]), @"peer", (self.encKey ? self.encKey : [NSNull null]), @"encKey", (self.profile ? [self.profile toMap] : [NSNull null]), @"profile", (self.groupProfile ? [self.groupProfile toMap] : [NSNull null]), @"groupProfile", nil];
}
@end

@implementation MSBOUserProfile
+(MSBOUserProfile*)fromMap:(NSDictionary*)dict {
  MSBOUserProfile* result = [[MSBOUserProfile alloc] init];
  result.address = dict[@"address"];
  if ((NSNull *)result.address == [NSNull null]) {
    result.address = nil;
  }
  result.name = dict[@"name"];
  if ((NSNull *)result.name == [NSNull null]) {
    result.name = nil;
  }
  result.status = dict[@"status"];
  if ((NSNull *)result.status == [NSNull null]) {
    result.status = nil;
  }
  result.picturePath = dict[@"picturePath"];
  if ((NSNull *)result.picturePath == [NSNull null]) {
    result.picturePath = nil;
  }
  result.draft = dict[@"draft"];
  if ((NSNull *)result.draft == [NSNull null]) {
    result.draft = nil;
  }
  result.unread = dict[@"unread"];
  if ((NSNull *)result.unread == [NSNull null]) {
    result.unread = nil;
  }
  result.groupId = dict[@"groupId"];
  if ((NSNull *)result.groupId == [NSNull null]) {
    result.groupId = nil;
  }
  result.flag = dict[@"flag"];
  if ((NSNull *)result.flag == [NSNull null]) {
    result.flag = nil;
  }
  result.timestamp = dict[@"timestamp"];
  if ((NSNull *)result.timestamp == [NSNull null]) {
    result.timestamp = nil;
  }
  result.lastActiveTime = dict[@"lastActiveTime"];
  if ((NSNull *)result.lastActiveTime == [NSNull null]) {
    result.lastActiveTime = nil;
  }
  result.do_not_use_in_app_code_isProfileNull = dict[@"do_not_use_in_app_code_isProfileNull"];
  if ((NSNull *)result.do_not_use_in_app_code_isProfileNull == [NSNull null]) {
    result.do_not_use_in_app_code_isProfileNull = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.address ? self.address : [NSNull null]), @"address", (self.name ? self.name : [NSNull null]), @"name", (self.status ? self.status : [NSNull null]), @"status", (self.picturePath ? self.picturePath : [NSNull null]), @"picturePath", (self.draft ? self.draft : [NSNull null]), @"draft", (self.unread ? self.unread : [NSNull null]), @"unread", (self.groupId ? self.groupId : [NSNull null]), @"groupId", (self.flag ? self.flag : [NSNull null]), @"flag", (self.timestamp ? self.timestamp : [NSNull null]), @"timestamp", (self.lastActiveTime ? self.lastActiveTime : [NSNull null]), @"lastActiveTime", (self.do_not_use_in_app_code_isProfileNull ? self.do_not_use_in_app_code_isProfileNull : [NSNull null]), @"do_not_use_in_app_code_isProfileNull", nil];
}
@end

@implementation MSBOConnectionStatus
+(MSBOConnectionStatus*)fromMap:(NSDictionary*)dict {
  MSBOConnectionStatus* result = [[MSBOConnectionStatus alloc] init];
  result.code = dict[@"code"];
  if ((NSNull *)result.code == [NSNull null]) {
    result.code = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.code ? self.code : [NSNull null]), @"code", nil];
}
@end

@implementation MSBOMesiboMessage
+(MSBOMesiboMessage*)fromMap:(NSDictionary*)dict {
  MSBOMesiboMessage* result = [[MSBOMesiboMessage alloc] init];
  result.params = [MSBOMessageParams fromMap:dict[@"params"]];
  if ((NSNull *)result.params == [NSNull null]) {
    result.params = nil;
  }
  result.data = dict[@"data"];
  if ((NSNull *)result.data == [NSNull null]) {
    result.data = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.params ? [self.params toMap] : [NSNull null]), @"params", (self.data ? self.data : [NSNull null]), @"data", nil];
}
@end

void MSBOMesiboRealTimeApiSetup(id<FlutterBinaryMessenger> binaryMessenger, id<MSBOMesiboRealTimeApi> api) {
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.MesiboRealTimeApi.setAccessToken"
        binaryMessenger:binaryMessenger];
    if (api) {
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        MSBOSetAccessTokenCommand *input = [MSBOSetAccessTokenCommand fromMap:message];
        FlutterError *error;
        [api setAccessToken:input error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.MesiboRealTimeApi.start"
        binaryMessenger:binaryMessenger];
    if (api) {
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        [api start:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.MesiboRealTimeApi.loadChatHistory"
        binaryMessenger:binaryMessenger];
    if (api) {
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        MSBOLoadChatHistoryCommand *input = [MSBOLoadChatHistoryCommand fromMap:message];
        FlutterError *error;
        MSBOChatHistoryResult *output = [api loadChatHistory:input error:&error];
        callback(wrapResult([output toMap], error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.MesiboRealTimeApi.loadChatSummary"
        binaryMessenger:binaryMessenger];
    if (api) {
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        MSBOLoadChatSummaryCommand *input = [MSBOLoadChatSummaryCommand fromMap:message];
        FlutterError *error;
        MSBOChatSummaryResult *output = [api loadChatSummary:input error:&error];
        callback(wrapResult([output toMap], error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.MesiboRealTimeApi.sendMessage"
        binaryMessenger:binaryMessenger];
    if (api) {
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        MSBOSendMessageCommand *input = [MSBOSendMessageCommand fromMap:message];
        FlutterError *error;
        MSBOSendMessageResult *output = [api sendMessage:input error:&error];
        callback(wrapResult([output toMap], error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
@interface MSBOMesiboConnectionListener ()
@property (nonatomic, strong) NSObject<FlutterBinaryMessenger>* binaryMessenger;
@end

@implementation MSBOMesiboConnectionListener
- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger>*)binaryMessenger {
  self = [super init];
  if (self) {
    _binaryMessenger = binaryMessenger;
  }
  return self;
}

- (void)onConnectionStatus:(MSBOConnectionStatus*)input completion:(void(^)(NSError* _Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.MesiboConnectionListener.onConnectionStatus"
      binaryMessenger:self.binaryMessenger];
  NSDictionary* inputMap = [input toMap];
  [channel sendMessage:inputMap reply:^(id reply) {
    completion(nil);
  }];
}
@end
@interface MSBOMesiboMessageListener ()
@property (nonatomic, strong) NSObject<FlutterBinaryMessenger>* binaryMessenger;
@end

@implementation MSBOMesiboMessageListener
- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger>*)binaryMessenger {
  self = [super init];
  if (self) {
    _binaryMessenger = binaryMessenger;
  }
  return self;
}

- (void)onMessage:(MSBOMesiboMessage*)input completion:(void(^)(NSError* _Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.MesiboMessageListener.onMessage"
      binaryMessenger:self.binaryMessenger];
  NSDictionary* inputMap = [input toMap];
  [channel sendMessage:inputMap reply:^(id reply) {
    completion(nil);
  }];
}
- (void)onMessageStatus:(MSBOMessageParams*)input completion:(void(^)(NSError* _Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.MesiboMessageListener.onMessageStatus"
      binaryMessenger:self.binaryMessenger];
  NSDictionary* inputMap = [input toMap];
  [channel sendMessage:inputMap reply:^(id reply) {
    completion(nil);
  }];
}
@end
