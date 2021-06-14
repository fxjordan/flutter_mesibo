// Autogenerated from Pigeon (v0.1.23), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

@class MSBOConnectionStatus;
@class MSBOMesiboMessage;
@class MSBOMessageParams;
@class MSBOUserProfile;
@class MSBOSetAccessTokenCommand;
@class MSBOSetPushTokenResult;
@class MSBOSetPushTokenCommand;
@class MSBOChatHistoryResult;
@class MSBOLoadChatHistoryCommand;
@class MSBOChatSummaryResult;
@class MSBOLoadChatSummaryCommand;
@class MSBOSendMessageResult;
@class MSBOSendMessageCommand;
@class MSBOGetRecentProfilesResult;

@interface MSBOConnectionStatus : NSObject
@property(nonatomic, strong, nullable) NSNumber * code;
@end

@interface MSBOMesiboMessage : NSObject
@property(nonatomic, strong, nullable) MSBOMessageParams * params;
@property(nonatomic, strong, nullable) FlutterStandardTypedData * data;
@end

@interface MSBOMessageParams : NSObject
@property(nonatomic, strong, nullable) NSNumber * mid;
@property(nonatomic, strong, nullable) NSNumber * groupId;
@property(nonatomic, strong, nullable) NSNumber * ts;
@property(nonatomic, strong, nullable) NSNumber * channel;
@property(nonatomic, strong, nullable) NSNumber * type;
@property(nonatomic, strong, nullable) NSNumber * expiry;
@property(nonatomic, strong, nullable) NSNumber * flag;
@property(nonatomic, strong, nullable) NSNumber * userFlags;
@property(nonatomic, strong, nullable) NSNumber * duration;
@property(nonatomic, strong, nullable) NSNumber * status;
@property(nonatomic, strong, nullable) NSNumber * origin;
@property(nonatomic, copy, nullable) NSString * peer;
@property(nonatomic, copy, nullable) NSString * encKey;
@property(nonatomic, strong, nullable) MSBOUserProfile * profile;
@property(nonatomic, strong, nullable) MSBOUserProfile * groupProfile;
@end

@interface MSBOUserProfile : NSObject
@property(nonatomic, copy, nullable) NSString * address;
@property(nonatomic, copy, nullable) NSString * name;
@property(nonatomic, copy, nullable) NSString * status;
@property(nonatomic, copy, nullable) NSString * picturePath;
@property(nonatomic, copy, nullable) NSString * draft;
@property(nonatomic, strong, nullable) NSNumber * unread;
@property(nonatomic, strong, nullable) NSNumber * groupId;
@property(nonatomic, strong, nullable) NSNumber * flag;
@property(nonatomic, strong, nullable) NSNumber * timestamp;
@property(nonatomic, strong, nullable) NSNumber * lastActiveTime;
@property(nonatomic, strong, nullable) NSNumber * do_not_use_in_app_code_isProfileNull;
@end

@interface MSBOSetAccessTokenCommand : NSObject
@property(nonatomic, copy, nullable) NSString * accessToken;
@end

@interface MSBOSetPushTokenResult : NSObject
@property(nonatomic, strong, nullable) NSNumber * result;
@end

@interface MSBOSetPushTokenCommand : NSObject
@property(nonatomic, copy, nullable) NSString * pushToken;
@end

@interface MSBOChatHistoryResult : NSObject
@property(nonatomic, strong, nullable) NSNumber * readCount;
@end

@interface MSBOLoadChatHistoryCommand : NSObject
@property(nonatomic, copy, nullable) NSString * peerAddress;
@property(nonatomic, strong, nullable) NSNumber * count;
@end

@interface MSBOChatSummaryResult : NSObject
@property(nonatomic, strong, nullable) NSNumber * readCount;
@end

@interface MSBOLoadChatSummaryCommand : NSObject
@property(nonatomic, strong, nullable) NSNumber * count;
@end

@interface MSBOSendMessageResult : NSObject
@property(nonatomic, strong, nullable) NSNumber * result;
@end

@interface MSBOSendMessageCommand : NSObject
@property(nonatomic, strong, nullable) MSBOMessageParams * params;
@property(nonatomic, strong, nullable) NSNumber * mid;
@property(nonatomic, strong, nullable) FlutterStandardTypedData * data;
@end

@interface MSBOGetRecentProfilesResult : NSObject
@property(nonatomic, strong, nullable) NSArray * profiles;
@end

@interface MSBOMesiboConnectionListener : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)onConnectionStatus:(MSBOConnectionStatus*)input completion:(void(^)(NSError* _Nullable))completion;
@end
@interface MSBOMesiboMessageListener : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)onMessage:(MSBOMesiboMessage*)input completion:(void(^)(NSError* _Nullable))completion;
- (void)onMessageStatus:(MSBOMessageParams*)input completion:(void(^)(NSError* _Nullable))completion;
@end
@protocol MSBOMesiboRealTimeApi
-(void)setAccessToken:(MSBOSetAccessTokenCommand*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(nullable MSBOSetPushTokenResult *)setPushToken:(MSBOSetPushTokenCommand*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)start:(FlutterError *_Nullable *_Nonnull)error;
-(nullable MSBOChatHistoryResult *)loadChatHistory:(MSBOLoadChatHistoryCommand*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(nullable MSBOChatSummaryResult *)loadChatSummary:(MSBOLoadChatSummaryCommand*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(nullable MSBOSendMessageResult *)sendMessage:(MSBOSendMessageCommand*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(nullable MSBOUserProfile *)getSelfProfile:(FlutterError *_Nullable *_Nonnull)error;
-(nullable MSBOGetRecentProfilesResult *)getRecentProfiles:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void MSBOMesiboRealTimeApiSetup(id<FlutterBinaryMessenger> binaryMessenger, id<MSBOMesiboRealTimeApi> _Nullable api);

NS_ASSUME_NONNULL_END
