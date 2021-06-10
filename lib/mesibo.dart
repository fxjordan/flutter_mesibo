/*
 * Copyright (c) BUDDY Activities UG (haftungsbeschränkt) - All Rights Reserved
 *
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * Proprietary and confidential
 *
 * Written by Felix Jordan <felix.jordan@buddy-app.de>, March, 2021
 */

import 'dart:async';
import 'dart:typed_data';

import 'package:observable_ish/event/event.dart';

import 'mesibo_binding.dart';

class Mesibo {

  MesiboRealTimeApi apiBinding = MesiboRealTimeApi();

  /// Connection listener that handles calls from platform channels (and delegates to actual app)
  _MesiboConnectionListenerImpl _connectionListenerImpl;

  /// Message listener that handles calls from platform channels (and delegates to actual app)
  _MesiboMessageListenerImpl _messageListenerImpl;

  final Emitter<MesiboMessage> _realTimeMessageEmitter = Emitter();
  /// Stream of incoming realtime messages.
  /// Messages that were received as a result of a DB request or DB summary are
  /// mot published to this stream.
  Stream<MesiboMessage> get realTimeMessageStream => _realTimeMessageEmitter.asStream;

  final Emitter<MessageParams> _messageStatusEmitter = Emitter();
  /// Stream of message status updates.
  Stream<MessageParams> get messageStatusStream => _messageStatusEmitter.asStream;

  static final Mesibo _instance = Mesibo._privateConstructor();
  static Mesibo get instance => _instance;

  Mesibo._privateConstructor() {
    _connectionListenerImpl =
        _MesiboConnectionListenerImpl();
    _messageListenerImpl =
        _MesiboMessageListenerImpl(_realTimeMessageEmitter, _messageStatusEmitter);

    // Setup platform channels for callbacks
    MesiboConnectionListener.setup(_connectionListenerImpl);
    MesiboMessageListener.setup(_messageListenerImpl);
  }

  Future<void> setAccessToken(String accessToken) {
    return apiBinding
        .setAccessToken(SetAccessTokenCommand()..accessToken = accessToken);
  }

  Future<void> start() {
    return apiBinding.start();
  }

  // Load chat history for with specific user (peer address)
  Future<List<MesiboMessage>> loadChatHistory(
      String peerAddress, int limit) async {
    LoadChatHistoryCommand cmd = LoadChatHistoryCommand();
    cmd.peerAddress = peerAddress;
    cmd.count = limit;

    // 1. Request chat history for address
    ChatHistoryResult result = await apiBinding.loadChatHistory(cmd);

    // 2. Wait to receive expected messages
    List<MesiboMessage> messages =
        await _messageListenerImpl.waitForDbMessages(result.readCount);
    print(
        'MESIBO: Received ${messages.length} messages for chat history (expected: ${result.readCount}, requestLimit: $limit)');
    return messages;
  }

  /// Load the latest x messages from all chats
  Future<List<MesiboMessage>> loadChatSummary(int limit) async {
    print('MESIBO: Loading chat summary (limit: $limit)');

    // 1. Request chat summary
    ChatSummaryResult result = await apiBinding
        .loadChatSummary(LoadChatSummaryCommand()..count = limit);

    // 2. Wait to receive the expected messages
    List<MesiboMessage> messages =
        await _messageListenerImpl.waitForDbMessages(result.readCount);
    print(
        'MESIBO: Received ${messages.length} messages for summary (expected: ${result.readCount}, requestLimit: $limit)');

    return messages;
  }

  Future<void> sendMessage(MessageParams params, int mid, Uint8List data) async {
    print('MESIBO: Sending message (mid=$mid)');
    SendMessageCommand cmd = SendMessageCommand();
    // IMPORTANT workaround: check method docs
    cmd.params = _preProcessOutgoingMessageParams(params);
    cmd.mid = mid;
    cmd.data = data;
    SendMessageResult result = await apiBinding.sendMessage(cmd);

    // Check result success or throw exception
    if (result.result != Mesibo.RESULT_OK) {
      throw Exception('Failed to send message (result: ${result.result})');
    }
    print('MESIBO: Message sent successfully (mid=$mid)');
  }

  /// Pre-process a [MessageParams] instance received from the platform channel.
  ///
  /// As a consequence of a bug workaround we have to represent a null property
  /// in a strange way. See [UserProfile] in 'pigeons/mesibo.dart' for more
  /// explanations.
  static MessageParams _preProcessReceivedMessageParams(MessageParams params) {
    if (params.profile != null &&
        params.profile.do_not_use_in_app_code_isProfileNull == true) {
      params.profile = null;
    }
    if (params.groupProfile != null &&
        params.groupProfile.do_not_use_in_app_code_isProfileNull == true) {
      params.groupProfile = null;
    }
    return params;
  }

  /// Bug workaround! see [_preProcessReceivedMessageParams].
  static MessageParams _preProcessOutgoingMessageParams(MessageParams params) {
    /*
     * BUG WORKAROUND: Check docs on UserProfile in pigeons/mesibo.dart template.
     */
    if (params.profile == null) {
      // Flutter code will transform this back to 'null'
      params.profile = NULL_USER_PROFILE;
    }
    if (params.groupProfile == null) {
      params.groupProfile = NULL_USER_PROFILE;
    }

    return params;
  }

  /*
   * BUG WORKAROUND: Check docs on UserProfile in pigeons/mesibo.dart template.
   */
  static final NULL_USER_PROFILE = UserProfile()..do_not_use_in_app_code_isProfileNull = true;

  /* =====
 * static constANTS copied from Android SDK 'Mesibo' class
 */

  static const int FLAG_DELIVERYRECEIPT = 1;
  static const int FLAG_READRECEIPT = 2;
  static const int FLAG_TRANSIENT = 4;
  static const int FLAG_FILETRANSFERRED = 65536;
  static const int FLAG_FILEFAILED = 131072;
  static const int FLAG_LASTMESSAGE = 8388608;
  static const int FLAG_EORS = 67108864;
  static const int FLAG_SAVECUSTOM = 33554432;
  static const int FLAG_DEFAULT = 3;

  static const int STATUS_UNKNOWN = 0;
  static const int STATUS_ONLINE = 1;
  static const int STATUS_OFFLINE = 2;
  static const int STATUS_SIGNOUT = 3;
  static const int STATUS_AUTHFAIL = 4;
  static const int STATUS_STOPPED = 5;
  static const int STATUS_CONNECTING = 6;
  static const int STATUS_CONNECTFAILURE = 7;
  static const int STATUS_NONETWORK = 8;
  static const int STATUS_MANDUPDATE = 10;
  static const int STATUS_SHUTDOWN = 20;
  static const int STATUS_ACTIVITY = -1;

  static const int MSGSTATUS_OUTBOX = 0;
  static const int MSGSTATUS_SENT = 1;
  static const int MSGSTATUS_DELIVERED = 2;
  static const int MSGSTATUS_READ = 3;
  static const int MSGSTATUS_RECEIVEDNEW = 18;
  static const int MSGSTATUS_RECEIVEDREAD = 19;
  static const int MSGSTATUS_CALLMISSED = 21;
  static const int MSGSTATUS_CALLINCOMING = 22;
  static const int MSGSTATUS_CALLOUTGOING = 23;
  static const int MSGSTATUS_CUSTOM = 32;
  static const int MSGSTATUS_FAIL = 128;
  static const int MSGSTATUS_USEROFFLINE = 129;
  static const int MSGSTATUS_INBOXFULL = 130;
  static const int MSGSTATUS_INVALIDDEST = 131;
  static const int MSGSTATUS_EXPIRED = 132;
  static const int MSGSTATUS_BLOCKED = 136;

  static const int MESIBO_DELETE_DEFAULT = -1;
  static const int MESIBO_DELETE_LOCAL = 0;
  static const int MESIBO_DELETE_RECALL = 1;
  static const int MESIBO_DELETE_REMOVE = 2;

  static const int RESULT_OK = 0;
  static const int RESULT_FAIL = 128;
  static const int RESULT_GENERROR = 129;
  static const int RESULT_NOSUCHUSER = 131;
  static const int RESULT_INBOXFULL = 132;
  static const int RESULT_BADREQ = 133;
  static const int RESULT_OVERCAPACITY = 134;
  static const int RESULT_RETRYLATER = 135;
  static const int RESULT_TIMEOUT = 176;
  static const int RESULT_CONNECTFAIL = 177;
  static const int RESULT_DISCONNECTED = 178;
  static const int RESULT_REQINPROGRESS = 179;
  static const int RESULT_BUFFERFULL = 180;
  static const int RESULT_AUTHFAIL = 192;
  static const int RESULT_DENIED = 193;

  static const int ORIGIN_REALTIME = 0;
  static const int ORIGIN_DBMESSAGE = 1;
  static const int ORIGIN_DBSUMMARY = 2;
  static const int ORIGIN_DBPENDING = 3;
  static const int ORIGIN_FILTER = 4;
  static const int ORIGIN_MESSAGESTATUS = 5;

  static const int ACTIVITY_NONE = 0;
  static const int ACTIVITY_ONLINE = 1;
  static const int ACTIVITY_ONLINERESP = 2;
  static const int ACTIVITY_TYPING = 3;
  static const int ACTIVITY_TYPINGCLEARED = 4;
  static const int ACTIVITY_JOINED = 10;
  static const int ACTIVITY_LEFT = 11;

  static const int PRESENCE_NONE = 0;
  static const int PRESENCE_ONLINE = 1;
  static const int PRESENCE_OFFLINE = 2;
  static const int PRESENCE_TYPING = 3;
  static const int PRESENCE_TYPINGCLEARED = 4;
  static const int PRESENCE_JOINED = 10;
  static const int PRESENCE_LEFT = 11;
  static const int PRESENCE_RESERVED = 255;

  static const int CONTACT_UPDATE = 0;
  static const int CONTACT_DELETE = 1;

  static const int CONNECTIVITY_UNKNOWN = -1;
  static const int CONNECTIVITY_DISCONNECTED = 255;
  static const int CONNECTIVITY_WIFI = 0;
  static const int CONNECTIVITY_2G = 1;
  static const int CONNECTIVITY_3G = 2;
  static const int CONNECTIVITY_4G = 3;

  static const int CALLSTATUS_NONE = 0;
  static const int CALLSTATUS_INCOMING = 1;
  static const int CALLSTATUS_INPROGRESS = 2;
  static const int CALLSTATUS_RINGING = 3;
  static const int CALLSTATUS_ANSWER = 5;
  static const int CALLSTATUS_UPDATE = 6;
  static const int CALLSTATUS_DTMF = 7;
  static const int CALLSTATUS_SDP = 8;
  static const int CALLSTATUS_MUTE = 9;
  static const int CALLSTATUS_UNMUTE = 10;
  static const int CALLSTATUS_HOLD = 11;
  static const int CALLSTATUS_UNHOLD = 12;
  static const int CALLSTATUS_PUBLISH = 13;
  static const int CALLSTATUS_PING = 33;
  static const int CALLSTATUS_INFO = 35;
  static const int CALLSTATUS_ECHO = 36;
  static const int CALLSTATUS_REDIRECT = 37;
  static const int CALLSTATUS_CHANNELUP = 48;
  static const int CALLSTATUS_CONNECTED = 48;
  static const int CALLSTATUS_QUALITY = 49;
  static const int CALLSTATUS_RECONNECTING = 50;
  static const int CALLSTATUS_SERVER = 58;
  static const int CALLSTATUS_COMPLETE = 64;
  static const int CALLSTATUS_CANCEL = 65;
  static const int CALLSTATUS_NOANSWER = 66;
  static const int CALLSTATUS_BUSY = 67;
  static const int CALLSTATUS_UNREACHABLE = 68;
  static const int CALLSTATUS_OFFLINE = 69;
  static const int CALLSTATUS_INVALIDDEST = 70;
  static const int CALLSTATUS_INVALIDSTATE = 71;
  static const int CALLSTATUS_NOCALLS = 72;
  static const int CALLSTATUS_NOVIDEOCALLS = 73;
  static const int CALLSTATUS_NOTALLOWED = 74;
  static const int CALLSTATUS_AUTHFAIL = 80;
  static const int CALLSTATUS_NOCREDITS = 81;
  static const int CALLSTATUS_NONTRINGMEDEST = 82;
  static const int CALLSTATUS_INCOMPATIBLE = 83;
  static const int CALLSTATUS_BADCALLID = 84;
  static const int CALLSTATUS_ERROR = 96;
  static const int CALLSTATUS_HWERROR = 97;
  static const int CALLSTATUS_NETWORKERROR = 98;
  static const int CALLSTATUS_NETWORKBLOCKED = 99;

  static const int CALLFLAG_AUDIO = 1;
  static const int CALLFLAG_VIDEO = 2;
  static const int CALLFLAG_STARTCALL = 4;
  static const int CALLFLAG_CALLWAITING = 8;
  static const int CALLFLAG_WIFI = 16;
  static const int CALLFLAG_SLOWNETWORK = 32;
  static const int CALLFLAG_MISSED = 4096;

  static const int CALL_MUTESTATUS_AUDIO = 1;
  static const int CALL_MUTESTATUS_VIDEO = 2;
  static const int CALL_MUTESTATUS_HOLD = 4;

  static const int DBTABLE_MESSAGES = 1;
  static const int DBTABLE_PROFILES = 2;
  static const int DBTABLE_KEYS = 4;
  static const int DBTABLE_ALL = 7;

  static const int SERVERTYPE_STUN = 0;
  static const int SERVERTYPE_TURN = 1;

  static String getConnectionStatusName(int statusCode) {
    String statusName;
    switch (statusCode) {
      case Mesibo.STATUS_ACTIVITY:
        statusName = 'activity';
        break;
      case Mesibo.STATUS_AUTHFAIL:
        statusName = 'auth fail';
        break;
      case Mesibo.STATUS_CONNECTFAILURE:
        statusName = 'connection failure';
        break;
      case Mesibo.STATUS_CONNECTING:
        statusName = 'connecting';
        break;
      case Mesibo.STATUS_MANDUPDATE:
        statusName = 'mandupdate';
        break;
      case Mesibo.STATUS_NONETWORK:
        statusName = 'no network';
        break;
      case Mesibo.STATUS_OFFLINE:
        statusName = 'offline';
        break;
      case Mesibo.STATUS_ONLINE:
        statusName = 'online';
        break;
      case Mesibo.STATUS_SHUTDOWN:
        statusName = 'shutdown';
        break;
      case Mesibo.STATUS_SIGNOUT:
        statusName = 'signout';
        break;
      case Mesibo.STATUS_STOPPED:
        statusName = 'stopped';
        break;
      case Mesibo.STATUS_UNKNOWN:
        statusName = 'unknown';
        break;
      default:
        statusName = 'unexpected status';
        break;
    }
    return statusName;
  }
}

/// Extension to add useful methods to the [MesiboMessage] class.
///
/// Needed because Pigeon doesn't allow us to define methods on
/// bridge classes.
extension MesiboMessageMethodExtension on MesiboMessage {

  /// Whether the message is an incoming message
  bool isIncoming() => params.status == Mesibo.MSGSTATUS_RECEIVEDNEW || params.status == Mesibo.MSGSTATUS_RECEIVEDREAD;
}

/// NOTE: This is only an internal implementation of the interface generated
/// by Pigeon. It must be setup correctly so the platform channel can work.
///
/// TODO This interface should either call a more abstract interface or publish
/// events to a stream in the future that are used by the application.
class _MesiboConnectionListenerImpl implements MesiboConnectionListener {

  @override
  void onConnectionStatus(ConnectionStatus status) {
    String statusName = Mesibo.getConnectionStatusName(status.code);

    print('MESIBO: Mesibo connection status: $statusName (${status.code})');
  }
}

/// Internal implementation of [MesiboMessageListener], that handles events from
/// the platform specific, actual message listener.
///
/// The implementation can buffer messages of DB read and DB summary request.
/// Also realtime messages are sent to a stream that is published by the
/// [Mesibo] abstraction to be used by application code.
class _MesiboMessageListenerImpl implements MesiboMessageListener {

  /// Emitter to publish real time messages.
  final Emitter<MesiboMessage> realTimeMessageEmitter;

  /// Emitter to publish message status updates.
  final Emitter<MessageParams> messageStatusEmitter;

  final List<MesiboMessage> _messageReadBuffer = [];

  /// Completer for the currently running read call. Is null when no call
  /// is running.
  Completer<List<MesiboMessage>> _messageReadCompleter;

  /// Number of messages the current running read call expects to receive.
  int _expectedMessageReadCount;

  _MesiboMessageListenerImpl(this.realTimeMessageEmitter, this.messageStatusEmitter);

  @override
  void onMessage(MesiboMessage message) {
    // IMPORTANT workaround: check method docs
    message.params = Mesibo._preProcessReceivedMessageParams(message.params);

    final origin = message.params.origin;

    print('MESIBO: onMessage: origin=$origin peer=${message.params.peer}');

    if (origin == Mesibo.ORIGIN_REALTIME) {
      // realtime -> emit on stream
      _onRealtimeMessage(message);
    } else if (origin == Mesibo.ORIGIN_DBSUMMARY ||
        origin == Mesibo.ORIGIN_DBMESSAGE) {
      // DB message -> buffer
      _onDbReadMessage(message);
    } else {
      print('MESIBO: WARN: message with unexpected origin: $origin');
    }
  }

  /// Called internally when a new chat message is received that was read from
  /// DB (not realtime)
  void _onDbReadMessage(MesiboMessage message) {
    // add to buffer anyway (completer may not have been initialized yet)
    _messageReadBuffer.add(message);
    print('new summary buffer size: ${_messageReadBuffer.length}');

    if (_messageReadCompleter == null) {
      print('MESIBO: ERROR: Received chat summary message, but not waiting for messages (yet)');
      return;
    }

    // check if we can complete the future
    if (_messageReadBuffer.length >= _expectedMessageReadCount) {
      print('completing future...');
      _messageReadCompleter.complete(List.of(_messageReadBuffer));

      _resetMessageReadFuture();
    } else {
      print(
          'waiting for more messages (expected count: $_expectedMessageReadCount)');
    }
  }

  /// Called internally when a new realtime message is received.
  void _onRealtimeMessage(MesiboMessage message) {
    print('Mesibo onRealTimeMessage: mid=${message.params.mid}, peer=${message.params.peer}');

    realTimeMessageEmitter.emitOne(message);
  }

  @override
  void onMessageStatus(MessageParams params) {
    print(
        'Mesibo onMessagStatus: peer=${params.peer}, status=${params.status}');

    messageStatusEmitter.emitOne(params);
  }

  /// Waits until the given number of expected DB read session messages were received
  /// through the listener and returns them.
  ///
  /// This can be used to get the messages, requested by a DB summary or DB query for
  /// messages of an individual chat.
  Future<List<MesiboMessage>> waitForDbMessages(int messageCount) {
    if (_messageReadCompleter != null) {
      throw StateError('already waiting for a summary to complete');
    }

    // 1. Check if we already received the expected messages
    if (_messageReadBuffer.length >= messageCount) {
      List<MesiboMessage> resultList = List.of(_messageReadBuffer);
      print(
          'Returning ${resultList.length} messages immediately (expected: $messageCount)');
      _resetMessageReadFuture();
      return Future.value(resultList);
    }

    // 2. If messages were not ready yet, return a future and complete later in onMessage listener

    _messageReadCompleter = Completer();
    // store message count to wait for
    _expectedMessageReadCount = messageCount;

    return _messageReadCompleter.future.timeout(
      Duration(seconds: 1),
      onTimeout: () {
        // cleanup
        _resetMessageReadFuture();

        if (_messageReadBuffer.isNotEmpty) {
          // at least we have something to return
          return List.of(_messageReadBuffer);
        }
        throw Exception('Expected chat summary messages were not returned');
      },
    );
  }

  void _resetMessageReadFuture() {
    _messageReadCompleter = null;
    _expectedMessageReadCount = null;
    _messageReadBuffer.clear();
  }
}
