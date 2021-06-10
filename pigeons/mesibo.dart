/*
 * Copyright (c) BUDDY Activities UG (haftungsbeschränkt) - All Rights Reserved
 *
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * Proprietary and confidential
 *
 * Written by Felix Jordan <felix.jordan@buddy-app.de>, March, 2021
 */

import 'package:pigeon/pigeon.dart';

/*
 * NOTE: Use 'flutter pub run pigeon --input pigeons/mesibo.dart' to generate code
 */

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

  /// Because of a Bug in pigeon (NullPointerException when property is null),
  /// we need to initialize the profile properties with an object even when it's
  /// null. In this object (only!) we set this property to true so the Flutter
  /// side can set those profile properties again to 'null'.
  ///
  /// Hopefully this improves when we upgrade 'pigeon', but we have to upgrade
  /// to full Dart null-safety before!
  bool do_not_use_in_app_code_isProfileNull;
}

class SetAccessTokenCommand {
  String accessToken;

  SetAccessTokenCommand(this.accessToken);
}

class LoadChatHistoryCommand {
  String peerAddress;
  int count;
}

class LoadChatSummaryCommand {
  int count;
}

class SendMessageCommand {
  MessageParams params;
  int mid;
  Uint8List data;
}

@HostApi()
abstract class MesiboRealTimeApi {
  void setAccessToken(SetAccessTokenCommand cmd);

  void start();

  // Load chat history for with specific user (peer address)
  ChatHistoryResult loadChatHistory(LoadChatHistoryCommand cmd);

  /// Load the latest x messages from all chats.
  ///
  /// Check the result for the number of messages that were read.
  ChatSummaryResult loadChatSummary(LoadChatSummaryCommand cmd);

  /// Send a message with the given ID, params, and data.
  ///
  /// Check the result code for success.
  SendMessageResult sendMessage(SendMessageCommand cmd);
}

class ChatHistoryResult {
  /// The number of messages read. Can be used to check if more messages
  /// will be received over the [MesiboMessageListener].
  int readCount;
}

class ChatSummaryResult {
  /// The number of messages read. Can be used to check if more messages
  /// will be received over the [MesiboMessageListener].
  int readCount;
}

class SendMessageResult {
  int result;
}

class ConnectionStatus {
  int code;
}

/// A Mesibo message represented by its raw data and [MessageParams].
class MesiboMessage {
  final MessageParams params;

  /// Raw message data encoded as string
  final Uint8List data;

  MesiboMessage(this.params, this.data);
}

@FlutterApi()
abstract class MesiboConnectionListener {
  void onConnectionStatus(ConnectionStatus status);
}

@FlutterApi()
abstract class MesiboMessageListener {
  void onMessage(MesiboMessage message);

  void onMessageStatus(MessageParams params);
}

void configurePigeon(PigeonOptions opts) {
  opts.dartOut = 'lib/mesibo_binding.dart';
  opts.dartTestOut = 'test/mesibo_binding_test.dart';
  opts.objcHeaderOut = 'ios/Classes/mesibo_binding.h';
  opts.objcSourceOut = 'ios/Classes/mesibo_binding.m';
  opts.objcOptions.prefix = 'MSBO';
  opts.javaOut =
      'android/src/main/kotlin/de/buddyactivities/fluttermesibo/MesiboBinding.java';
  opts.javaOptions.package = 'de.buddyactivities.fluttermesibo';
}
