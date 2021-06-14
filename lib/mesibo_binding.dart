// Autogenerated from Pigeon (v0.1.23), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators
// @dart = 2.8
import 'dart:async';
import 'dart:typed_data' show Uint8List, Int32List, Int64List, Float64List;

import 'package:flutter/services.dart';

class ConnectionStatus {
  int code;

  Object encode() {
    final Map<Object, Object> pigeonMap = <Object, Object>{};
    pigeonMap['code'] = code;
    return pigeonMap;
  }

  static ConnectionStatus decode(Object message) {
    final Map<Object, Object> pigeonMap = message as Map<Object, Object>;
    return ConnectionStatus()
      ..code = pigeonMap['code'] as int;
  }
}

class MesiboMessage {
  MessageParams params;
  Uint8List data;

  Object encode() {
    final Map<Object, Object> pigeonMap = <Object, Object>{};
    pigeonMap['params'] = params == null ? null : params.encode();
    pigeonMap['data'] = data;
    return pigeonMap;
  }

  static MesiboMessage decode(Object message) {
    final Map<Object, Object> pigeonMap = message as Map<Object, Object>;
    return MesiboMessage()
      ..params = pigeonMap['params'] != null ? MessageParams.decode(pigeonMap['params']) : null
      ..data = pigeonMap['data'] as Uint8List;
  }
}

class MessageParams {
  int mid;
  int groupId;
  int ts;
  int channel;
  int type;
  int expiry;
  int flag;
  int userFlags;
  int duration;
  int status;
  int origin;
  String peer;
  String encKey;
  UserProfile profile;
  UserProfile groupProfile;

  Object encode() {
    final Map<Object, Object> pigeonMap = <Object, Object>{};
    pigeonMap['mid'] = mid;
    pigeonMap['groupId'] = groupId;
    pigeonMap['ts'] = ts;
    pigeonMap['channel'] = channel;
    pigeonMap['type'] = type;
    pigeonMap['expiry'] = expiry;
    pigeonMap['flag'] = flag;
    pigeonMap['userFlags'] = userFlags;
    pigeonMap['duration'] = duration;
    pigeonMap['status'] = status;
    pigeonMap['origin'] = origin;
    pigeonMap['peer'] = peer;
    pigeonMap['encKey'] = encKey;
    pigeonMap['profile'] = profile == null ? null : profile.encode();
    pigeonMap['groupProfile'] = groupProfile == null ? null : groupProfile.encode();
    return pigeonMap;
  }

  static MessageParams decode(Object message) {
    final Map<Object, Object> pigeonMap = message as Map<Object, Object>;
    return MessageParams()
      ..mid = pigeonMap['mid'] as int
      ..groupId = pigeonMap['groupId'] as int
      ..ts = pigeonMap['ts'] as int
      ..channel = pigeonMap['channel'] as int
      ..type = pigeonMap['type'] as int
      ..expiry = pigeonMap['expiry'] as int
      ..flag = pigeonMap['flag'] as int
      ..userFlags = pigeonMap['userFlags'] as int
      ..duration = pigeonMap['duration'] as int
      ..status = pigeonMap['status'] as int
      ..origin = pigeonMap['origin'] as int
      ..peer = pigeonMap['peer'] as String
      ..encKey = pigeonMap['encKey'] as String
      ..profile = pigeonMap['profile'] != null ? UserProfile.decode(pigeonMap['profile']) : null
      ..groupProfile = pigeonMap['groupProfile'] != null ? UserProfile.decode(pigeonMap['groupProfile']) : null;
  }
}

class UserProfile {
  String address;
  String name;
  String status;
  String picturePath;
  String draft;
  int unread;
  int groupId;
  int flag;
  int timestamp;
  int lastActiveTime;
  bool do_not_use_in_app_code_isProfileNull;

  Object encode() {
    final Map<Object, Object> pigeonMap = <Object, Object>{};
    pigeonMap['address'] = address;
    pigeonMap['name'] = name;
    pigeonMap['status'] = status;
    pigeonMap['picturePath'] = picturePath;
    pigeonMap['draft'] = draft;
    pigeonMap['unread'] = unread;
    pigeonMap['groupId'] = groupId;
    pigeonMap['flag'] = flag;
    pigeonMap['timestamp'] = timestamp;
    pigeonMap['lastActiveTime'] = lastActiveTime;
    pigeonMap['do_not_use_in_app_code_isProfileNull'] = do_not_use_in_app_code_isProfileNull;
    return pigeonMap;
  }

  static UserProfile decode(Object message) {
    final Map<Object, Object> pigeonMap = message as Map<Object, Object>;
    return UserProfile()
      ..address = pigeonMap['address'] as String
      ..name = pigeonMap['name'] as String
      ..status = pigeonMap['status'] as String
      ..picturePath = pigeonMap['picturePath'] as String
      ..draft = pigeonMap['draft'] as String
      ..unread = pigeonMap['unread'] as int
      ..groupId = pigeonMap['groupId'] as int
      ..flag = pigeonMap['flag'] as int
      ..timestamp = pigeonMap['timestamp'] as int
      ..lastActiveTime = pigeonMap['lastActiveTime'] as int
      ..do_not_use_in_app_code_isProfileNull = pigeonMap['do_not_use_in_app_code_isProfileNull'] as bool;
  }
}

class SetAccessTokenCommand {
  String accessToken;

  Object encode() {
    final Map<Object, Object> pigeonMap = <Object, Object>{};
    pigeonMap['accessToken'] = accessToken;
    return pigeonMap;
  }

  static SetAccessTokenCommand decode(Object message) {
    final Map<Object, Object> pigeonMap = message as Map<Object, Object>;
    return SetAccessTokenCommand()
      ..accessToken = pigeonMap['accessToken'] as String;
  }
}

class SetPushTokenResult {
  int result;

  Object encode() {
    final Map<Object, Object> pigeonMap = <Object, Object>{};
    pigeonMap['result'] = result;
    return pigeonMap;
  }

  static SetPushTokenResult decode(Object message) {
    final Map<Object, Object> pigeonMap = message as Map<Object, Object>;
    return SetPushTokenResult()
      ..result = pigeonMap['result'] as int;
  }
}

class SetPushTokenCommand {
  String pushToken;

  Object encode() {
    final Map<Object, Object> pigeonMap = <Object, Object>{};
    pigeonMap['pushToken'] = pushToken;
    return pigeonMap;
  }

  static SetPushTokenCommand decode(Object message) {
    final Map<Object, Object> pigeonMap = message as Map<Object, Object>;
    return SetPushTokenCommand()
      ..pushToken = pigeonMap['pushToken'] as String;
  }
}

class ChatHistoryResult {
  int readCount;

  Object encode() {
    final Map<Object, Object> pigeonMap = <Object, Object>{};
    pigeonMap['readCount'] = readCount;
    return pigeonMap;
  }

  static ChatHistoryResult decode(Object message) {
    final Map<Object, Object> pigeonMap = message as Map<Object, Object>;
    return ChatHistoryResult()
      ..readCount = pigeonMap['readCount'] as int;
  }
}

class LoadChatHistoryCommand {
  String peerAddress;
  int count;

  Object encode() {
    final Map<Object, Object> pigeonMap = <Object, Object>{};
    pigeonMap['peerAddress'] = peerAddress;
    pigeonMap['count'] = count;
    return pigeonMap;
  }

  static LoadChatHistoryCommand decode(Object message) {
    final Map<Object, Object> pigeonMap = message as Map<Object, Object>;
    return LoadChatHistoryCommand()
      ..peerAddress = pigeonMap['peerAddress'] as String
      ..count = pigeonMap['count'] as int;
  }
}

class ChatSummaryResult {
  int readCount;

  Object encode() {
    final Map<Object, Object> pigeonMap = <Object, Object>{};
    pigeonMap['readCount'] = readCount;
    return pigeonMap;
  }

  static ChatSummaryResult decode(Object message) {
    final Map<Object, Object> pigeonMap = message as Map<Object, Object>;
    return ChatSummaryResult()
      ..readCount = pigeonMap['readCount'] as int;
  }
}

class LoadChatSummaryCommand {
  int count;

  Object encode() {
    final Map<Object, Object> pigeonMap = <Object, Object>{};
    pigeonMap['count'] = count;
    return pigeonMap;
  }

  static LoadChatSummaryCommand decode(Object message) {
    final Map<Object, Object> pigeonMap = message as Map<Object, Object>;
    return LoadChatSummaryCommand()
      ..count = pigeonMap['count'] as int;
  }
}

class SendMessageResult {
  int result;

  Object encode() {
    final Map<Object, Object> pigeonMap = <Object, Object>{};
    pigeonMap['result'] = result;
    return pigeonMap;
  }

  static SendMessageResult decode(Object message) {
    final Map<Object, Object> pigeonMap = message as Map<Object, Object>;
    return SendMessageResult()
      ..result = pigeonMap['result'] as int;
  }
}

class SendMessageCommand {
  MessageParams params;
  int mid;
  Uint8List data;

  Object encode() {
    final Map<Object, Object> pigeonMap = <Object, Object>{};
    pigeonMap['params'] = params == null ? null : params.encode();
    pigeonMap['mid'] = mid;
    pigeonMap['data'] = data;
    return pigeonMap;
  }

  static SendMessageCommand decode(Object message) {
    final Map<Object, Object> pigeonMap = message as Map<Object, Object>;
    return SendMessageCommand()
      ..params = pigeonMap['params'] != null ? MessageParams.decode(pigeonMap['params']) : null
      ..mid = pigeonMap['mid'] as int
      ..data = pigeonMap['data'] as Uint8List;
  }
}

class GetRecentProfilesResult {
  List<Object> profiles;

  Object encode() {
    final Map<Object, Object> pigeonMap = <Object, Object>{};
    pigeonMap['profiles'] = profiles;
    return pigeonMap;
  }

  static GetRecentProfilesResult decode(Object message) {
    final Map<Object, Object> pigeonMap = message as Map<Object, Object>;
    return GetRecentProfilesResult()
      ..profiles = pigeonMap['profiles'] as List<Object>;
  }
}

abstract class MesiboConnectionListener {
  void onConnectionStatus(ConnectionStatus arg);
  static void setup(MesiboConnectionListener api) {
    {
      const BasicMessageChannel<Object> channel =
          BasicMessageChannel<Object>('dev.flutter.pigeon.MesiboConnectionListener.onConnectionStatus', StandardMessageCodec());
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.MesiboConnectionListener.onConnectionStatus was null. Expected ConnectionStatus.');
          final ConnectionStatus input = ConnectionStatus.decode(message);
          api.onConnectionStatus(input);
          return;
        });
      }
    }
  }
}

abstract class MesiboMessageListener {
  void onMessage(MesiboMessage arg);
  void onMessageStatus(MessageParams arg);
  static void setup(MesiboMessageListener api) {
    {
      const BasicMessageChannel<Object> channel =
          BasicMessageChannel<Object>('dev.flutter.pigeon.MesiboMessageListener.onMessage', StandardMessageCodec());
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.MesiboMessageListener.onMessage was null. Expected MesiboMessage.');
          final MesiboMessage input = MesiboMessage.decode(message);
          api.onMessage(input);
          return;
        });
      }
    }
    {
      const BasicMessageChannel<Object> channel =
          BasicMessageChannel<Object>('dev.flutter.pigeon.MesiboMessageListener.onMessageStatus', StandardMessageCodec());
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.MesiboMessageListener.onMessageStatus was null. Expected MessageParams.');
          final MessageParams input = MessageParams.decode(message);
          api.onMessageStatus(input);
          return;
        });
      }
    }
  }
}

class MesiboRealTimeApi {
  Future<void> setAccessToken(SetAccessTokenCommand arg) async {
    final Object encoded = arg.encode();
    const BasicMessageChannel<Object> channel =
        BasicMessageChannel<Object>('dev.flutter.pigeon.MesiboRealTimeApi.setAccessToken', StandardMessageCodec());
    final Map<Object, Object> replyMap = await channel.send(encoded) as Map<Object, Object>;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object, Object> error = (replyMap['error'] as Map<Object, Object>);
      throw PlatformException(
        code: (error['code'] as String),
        message: error['message'] as String,
        details: error['details'],
      );
    } else {
      // noop
    }
  }

  Future<SetPushTokenResult> setPushToken(SetPushTokenCommand arg) async {
    final Object encoded = arg.encode();
    const BasicMessageChannel<Object> channel =
        BasicMessageChannel<Object>('dev.flutter.pigeon.MesiboRealTimeApi.setPushToken', StandardMessageCodec());
    final Map<Object, Object> replyMap = await channel.send(encoded) as Map<Object, Object>;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object, Object> error = (replyMap['error'] as Map<Object, Object>);
      throw PlatformException(
        code: (error['code'] as String),
        message: error['message'] as String,
        details: error['details'],
      );
    } else {
      return SetPushTokenResult.decode(replyMap['result']);
    }
  }

  Future<void> start() async {
    const BasicMessageChannel<Object> channel =
        BasicMessageChannel<Object>('dev.flutter.pigeon.MesiboRealTimeApi.start', StandardMessageCodec());
    final Map<Object, Object> replyMap = await channel.send(null) as Map<Object, Object>;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object, Object> error = (replyMap['error'] as Map<Object, Object>);
      throw PlatformException(
        code: (error['code'] as String),
        message: error['message'] as String,
        details: error['details'],
      );
    } else {
      // noop
    }
  }

  Future<ChatHistoryResult> loadChatHistory(LoadChatHistoryCommand arg) async {
    final Object encoded = arg.encode();
    const BasicMessageChannel<Object> channel =
        BasicMessageChannel<Object>('dev.flutter.pigeon.MesiboRealTimeApi.loadChatHistory', StandardMessageCodec());
    final Map<Object, Object> replyMap = await channel.send(encoded) as Map<Object, Object>;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object, Object> error = (replyMap['error'] as Map<Object, Object>);
      throw PlatformException(
        code: (error['code'] as String),
        message: error['message'] as String,
        details: error['details'],
      );
    } else {
      return ChatHistoryResult.decode(replyMap['result']);
    }
  }

  Future<ChatSummaryResult> loadChatSummary(LoadChatSummaryCommand arg) async {
    final Object encoded = arg.encode();
    const BasicMessageChannel<Object> channel =
        BasicMessageChannel<Object>('dev.flutter.pigeon.MesiboRealTimeApi.loadChatSummary', StandardMessageCodec());
    final Map<Object, Object> replyMap = await channel.send(encoded) as Map<Object, Object>;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object, Object> error = (replyMap['error'] as Map<Object, Object>);
      throw PlatformException(
        code: (error['code'] as String),
        message: error['message'] as String,
        details: error['details'],
      );
    } else {
      return ChatSummaryResult.decode(replyMap['result']);
    }
  }

  Future<SendMessageResult> sendMessage(SendMessageCommand arg) async {
    final Object encoded = arg.encode();
    const BasicMessageChannel<Object> channel =
        BasicMessageChannel<Object>('dev.flutter.pigeon.MesiboRealTimeApi.sendMessage', StandardMessageCodec());
    final Map<Object, Object> replyMap = await channel.send(encoded) as Map<Object, Object>;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object, Object> error = (replyMap['error'] as Map<Object, Object>);
      throw PlatformException(
        code: (error['code'] as String),
        message: error['message'] as String,
        details: error['details'],
      );
    } else {
      return SendMessageResult.decode(replyMap['result']);
    }
  }

  Future<UserProfile> getSelfProfile() async {
    const BasicMessageChannel<Object> channel =
        BasicMessageChannel<Object>('dev.flutter.pigeon.MesiboRealTimeApi.getSelfProfile', StandardMessageCodec());
    final Map<Object, Object> replyMap = await channel.send(null) as Map<Object, Object>;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object, Object> error = (replyMap['error'] as Map<Object, Object>);
      throw PlatformException(
        code: (error['code'] as String),
        message: error['message'] as String,
        details: error['details'],
      );
    } else {
      return UserProfile.decode(replyMap['result']);
    }
  }

  Future<GetRecentProfilesResult> getRecentProfiles() async {
    const BasicMessageChannel<Object> channel =
        BasicMessageChannel<Object>('dev.flutter.pigeon.MesiboRealTimeApi.getRecentProfiles', StandardMessageCodec());
    final Map<Object, Object> replyMap = await channel.send(null) as Map<Object, Object>;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object, Object> error = (replyMap['error'] as Map<Object, Object>);
      throw PlatformException(
        code: (error['code'] as String),
        message: error['message'] as String,
        details: error['details'],
      );
    } else {
      return GetRecentProfilesResult.decode(replyMap['result']);
    }
  }
}
