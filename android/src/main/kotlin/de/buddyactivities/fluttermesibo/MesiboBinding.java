// Autogenerated from Pigeon (v0.1.23), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package de.buddyactivities.fluttermesibo;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

/** Generated class from Pigeon. */
@SuppressWarnings({"unused", "unchecked", "CodeBlock2Expr", "RedundantSuppression"})
public class MesiboBinding {

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class SetAccessTokenCommand {
    private String accessToken;
    public String getAccessToken() { return accessToken; }
    public void setAccessToken(String setterArg) { this.accessToken = setterArg; }

    Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("accessToken", accessToken);
      return toMapResult;
    }
    static SetAccessTokenCommand fromMap(Map<String, Object> map) {
      SetAccessTokenCommand fromMapResult = new SetAccessTokenCommand();
      Object accessToken = map.get("accessToken");
      fromMapResult.accessToken = (String)accessToken;
      return fromMapResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class ChatHistoryResult {
    private Long readCount;
    public Long getReadCount() { return readCount; }
    public void setReadCount(Long setterArg) { this.readCount = setterArg; }

    Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("readCount", readCount);
      return toMapResult;
    }
    static ChatHistoryResult fromMap(Map<String, Object> map) {
      ChatHistoryResult fromMapResult = new ChatHistoryResult();
      Object readCount = map.get("readCount");
      fromMapResult.readCount = (readCount == null) ? null : ((readCount instanceof Integer) ? (Integer)readCount : (Long)readCount);
      return fromMapResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class LoadChatHistoryCommand {
    private String peerAddress;
    public String getPeerAddress() { return peerAddress; }
    public void setPeerAddress(String setterArg) { this.peerAddress = setterArg; }

    private Long count;
    public Long getCount() { return count; }
    public void setCount(Long setterArg) { this.count = setterArg; }

    Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("peerAddress", peerAddress);
      toMapResult.put("count", count);
      return toMapResult;
    }
    static LoadChatHistoryCommand fromMap(Map<String, Object> map) {
      LoadChatHistoryCommand fromMapResult = new LoadChatHistoryCommand();
      Object peerAddress = map.get("peerAddress");
      fromMapResult.peerAddress = (String)peerAddress;
      Object count = map.get("count");
      fromMapResult.count = (count == null) ? null : ((count instanceof Integer) ? (Integer)count : (Long)count);
      return fromMapResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class ChatSummaryResult {
    private Long readCount;
    public Long getReadCount() { return readCount; }
    public void setReadCount(Long setterArg) { this.readCount = setterArg; }

    Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("readCount", readCount);
      return toMapResult;
    }
    static ChatSummaryResult fromMap(Map<String, Object> map) {
      ChatSummaryResult fromMapResult = new ChatSummaryResult();
      Object readCount = map.get("readCount");
      fromMapResult.readCount = (readCount == null) ? null : ((readCount instanceof Integer) ? (Integer)readCount : (Long)readCount);
      return fromMapResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class LoadChatSummaryCommand {
    private Long count;
    public Long getCount() { return count; }
    public void setCount(Long setterArg) { this.count = setterArg; }

    Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("count", count);
      return toMapResult;
    }
    static LoadChatSummaryCommand fromMap(Map<String, Object> map) {
      LoadChatSummaryCommand fromMapResult = new LoadChatSummaryCommand();
      Object count = map.get("count");
      fromMapResult.count = (count == null) ? null : ((count instanceof Integer) ? (Integer)count : (Long)count);
      return fromMapResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class SendMessageResult {
    private Long result;
    public Long getResult() { return result; }
    public void setResult(Long setterArg) { this.result = setterArg; }

    Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("result", result);
      return toMapResult;
    }
    static SendMessageResult fromMap(Map<String, Object> map) {
      SendMessageResult fromMapResult = new SendMessageResult();
      Object result = map.get("result");
      fromMapResult.result = (result == null) ? null : ((result instanceof Integer) ? (Integer)result : (Long)result);
      return fromMapResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class SendMessageCommand {
    private MessageParams params;
    public MessageParams getParams() { return params; }
    public void setParams(MessageParams setterArg) { this.params = setterArg; }

    private Long mid;
    public Long getMid() { return mid; }
    public void setMid(Long setterArg) { this.mid = setterArg; }

    private byte[] data;
    public byte[] getData() { return data; }
    public void setData(byte[] setterArg) { this.data = setterArg; }

    Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("params", params.toMap());
      toMapResult.put("mid", mid);
      toMapResult.put("data", data);
      return toMapResult;
    }
    static SendMessageCommand fromMap(Map<String, Object> map) {
      SendMessageCommand fromMapResult = new SendMessageCommand();
      Object params = map.get("params");
      fromMapResult.params = MessageParams.fromMap((Map)params);
      Object mid = map.get("mid");
      fromMapResult.mid = (mid == null) ? null : ((mid instanceof Integer) ? (Integer)mid : (Long)mid);
      Object data = map.get("data");
      fromMapResult.data = (byte[])data;
      return fromMapResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class MessageParams {
    private Long mid;
    public Long getMid() { return mid; }
    public void setMid(Long setterArg) { this.mid = setterArg; }

    private Long groupId;
    public Long getGroupId() { return groupId; }
    public void setGroupId(Long setterArg) { this.groupId = setterArg; }

    private Long ts;
    public Long getTs() { return ts; }
    public void setTs(Long setterArg) { this.ts = setterArg; }

    private Long channel;
    public Long getChannel() { return channel; }
    public void setChannel(Long setterArg) { this.channel = setterArg; }

    private Long type;
    public Long getType() { return type; }
    public void setType(Long setterArg) { this.type = setterArg; }

    private Long expiry;
    public Long getExpiry() { return expiry; }
    public void setExpiry(Long setterArg) { this.expiry = setterArg; }

    private Long flag;
    public Long getFlag() { return flag; }
    public void setFlag(Long setterArg) { this.flag = setterArg; }

    private Long userFlags;
    public Long getUserFlags() { return userFlags; }
    public void setUserFlags(Long setterArg) { this.userFlags = setterArg; }

    private Long duration;
    public Long getDuration() { return duration; }
    public void setDuration(Long setterArg) { this.duration = setterArg; }

    private Long status;
    public Long getStatus() { return status; }
    public void setStatus(Long setterArg) { this.status = setterArg; }

    private Long origin;
    public Long getOrigin() { return origin; }
    public void setOrigin(Long setterArg) { this.origin = setterArg; }

    private String peer;
    public String getPeer() { return peer; }
    public void setPeer(String setterArg) { this.peer = setterArg; }

    private String encKey;
    public String getEncKey() { return encKey; }
    public void setEncKey(String setterArg) { this.encKey = setterArg; }

    private UserProfile profile;
    public UserProfile getProfile() { return profile; }
    public void setProfile(UserProfile setterArg) { this.profile = setterArg; }

    private UserProfile groupProfile;
    public UserProfile getGroupProfile() { return groupProfile; }
    public void setGroupProfile(UserProfile setterArg) { this.groupProfile = setterArg; }

    Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("mid", mid);
      toMapResult.put("groupId", groupId);
      toMapResult.put("ts", ts);
      toMapResult.put("channel", channel);
      toMapResult.put("type", type);
      toMapResult.put("expiry", expiry);
      toMapResult.put("flag", flag);
      toMapResult.put("userFlags", userFlags);
      toMapResult.put("duration", duration);
      toMapResult.put("status", status);
      toMapResult.put("origin", origin);
      toMapResult.put("peer", peer);
      toMapResult.put("encKey", encKey);
      toMapResult.put("profile", profile.toMap());
      toMapResult.put("groupProfile", groupProfile.toMap());
      return toMapResult;
    }
    static MessageParams fromMap(Map<String, Object> map) {
      MessageParams fromMapResult = new MessageParams();
      Object mid = map.get("mid");
      fromMapResult.mid = (mid == null) ? null : ((mid instanceof Integer) ? (Integer)mid : (Long)mid);
      Object groupId = map.get("groupId");
      fromMapResult.groupId = (groupId == null) ? null : ((groupId instanceof Integer) ? (Integer)groupId : (Long)groupId);
      Object ts = map.get("ts");
      fromMapResult.ts = (ts == null) ? null : ((ts instanceof Integer) ? (Integer)ts : (Long)ts);
      Object channel = map.get("channel");
      fromMapResult.channel = (channel == null) ? null : ((channel instanceof Integer) ? (Integer)channel : (Long)channel);
      Object type = map.get("type");
      fromMapResult.type = (type == null) ? null : ((type instanceof Integer) ? (Integer)type : (Long)type);
      Object expiry = map.get("expiry");
      fromMapResult.expiry = (expiry == null) ? null : ((expiry instanceof Integer) ? (Integer)expiry : (Long)expiry);
      Object flag = map.get("flag");
      fromMapResult.flag = (flag == null) ? null : ((flag instanceof Integer) ? (Integer)flag : (Long)flag);
      Object userFlags = map.get("userFlags");
      fromMapResult.userFlags = (userFlags == null) ? null : ((userFlags instanceof Integer) ? (Integer)userFlags : (Long)userFlags);
      Object duration = map.get("duration");
      fromMapResult.duration = (duration == null) ? null : ((duration instanceof Integer) ? (Integer)duration : (Long)duration);
      Object status = map.get("status");
      fromMapResult.status = (status == null) ? null : ((status instanceof Integer) ? (Integer)status : (Long)status);
      Object origin = map.get("origin");
      fromMapResult.origin = (origin == null) ? null : ((origin instanceof Integer) ? (Integer)origin : (Long)origin);
      Object peer = map.get("peer");
      fromMapResult.peer = (String)peer;
      Object encKey = map.get("encKey");
      fromMapResult.encKey = (String)encKey;
      Object profile = map.get("profile");
      fromMapResult.profile = UserProfile.fromMap((Map)profile);
      Object groupProfile = map.get("groupProfile");
      fromMapResult.groupProfile = UserProfile.fromMap((Map)groupProfile);
      return fromMapResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class UserProfile {
    private String address;
    public String getAddress() { return address; }
    public void setAddress(String setterArg) { this.address = setterArg; }

    private String name;
    public String getName() { return name; }
    public void setName(String setterArg) { this.name = setterArg; }

    private String status;
    public String getStatus() { return status; }
    public void setStatus(String setterArg) { this.status = setterArg; }

    private String picturePath;
    public String getPicturePath() { return picturePath; }
    public void setPicturePath(String setterArg) { this.picturePath = setterArg; }

    private String draft;
    public String getDraft() { return draft; }
    public void setDraft(String setterArg) { this.draft = setterArg; }

    private Long unread;
    public Long getUnread() { return unread; }
    public void setUnread(Long setterArg) { this.unread = setterArg; }

    private Long groupId;
    public Long getGroupId() { return groupId; }
    public void setGroupId(Long setterArg) { this.groupId = setterArg; }

    private Long flag;
    public Long getFlag() { return flag; }
    public void setFlag(Long setterArg) { this.flag = setterArg; }

    private Long timestamp;
    public Long getTimestamp() { return timestamp; }
    public void setTimestamp(Long setterArg) { this.timestamp = setterArg; }

    private Long lastActiveTime;
    public Long getLastActiveTime() { return lastActiveTime; }
    public void setLastActiveTime(Long setterArg) { this.lastActiveTime = setterArg; }

    private Boolean do_not_use_in_app_code_isProfileNull;
    public Boolean getDo_not_use_in_app_code_isProfileNull() { return do_not_use_in_app_code_isProfileNull; }
    public void setDo_not_use_in_app_code_isProfileNull(Boolean setterArg) { this.do_not_use_in_app_code_isProfileNull = setterArg; }

    Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("address", address);
      toMapResult.put("name", name);
      toMapResult.put("status", status);
      toMapResult.put("picturePath", picturePath);
      toMapResult.put("draft", draft);
      toMapResult.put("unread", unread);
      toMapResult.put("groupId", groupId);
      toMapResult.put("flag", flag);
      toMapResult.put("timestamp", timestamp);
      toMapResult.put("lastActiveTime", lastActiveTime);
      toMapResult.put("do_not_use_in_app_code_isProfileNull", do_not_use_in_app_code_isProfileNull);
      return toMapResult;
    }
    static UserProfile fromMap(Map<String, Object> map) {
      UserProfile fromMapResult = new UserProfile();
      Object address = map.get("address");
      fromMapResult.address = (String)address;
      Object name = map.get("name");
      fromMapResult.name = (String)name;
      Object status = map.get("status");
      fromMapResult.status = (String)status;
      Object picturePath = map.get("picturePath");
      fromMapResult.picturePath = (String)picturePath;
      Object draft = map.get("draft");
      fromMapResult.draft = (String)draft;
      Object unread = map.get("unread");
      fromMapResult.unread = (unread == null) ? null : ((unread instanceof Integer) ? (Integer)unread : (Long)unread);
      Object groupId = map.get("groupId");
      fromMapResult.groupId = (groupId == null) ? null : ((groupId instanceof Integer) ? (Integer)groupId : (Long)groupId);
      Object flag = map.get("flag");
      fromMapResult.flag = (flag == null) ? null : ((flag instanceof Integer) ? (Integer)flag : (Long)flag);
      Object timestamp = map.get("timestamp");
      fromMapResult.timestamp = (timestamp == null) ? null : ((timestamp instanceof Integer) ? (Integer)timestamp : (Long)timestamp);
      Object lastActiveTime = map.get("lastActiveTime");
      fromMapResult.lastActiveTime = (lastActiveTime == null) ? null : ((lastActiveTime instanceof Integer) ? (Integer)lastActiveTime : (Long)lastActiveTime);
      Object do_not_use_in_app_code_isProfileNull = map.get("do_not_use_in_app_code_isProfileNull");
      fromMapResult.do_not_use_in_app_code_isProfileNull = (Boolean)do_not_use_in_app_code_isProfileNull;
      return fromMapResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class ConnectionStatus {
    private Long code;
    public Long getCode() { return code; }
    public void setCode(Long setterArg) { this.code = setterArg; }

    Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("code", code);
      return toMapResult;
    }
    static ConnectionStatus fromMap(Map<String, Object> map) {
      ConnectionStatus fromMapResult = new ConnectionStatus();
      Object code = map.get("code");
      fromMapResult.code = (code == null) ? null : ((code instanceof Integer) ? (Integer)code : (Long)code);
      return fromMapResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class MesiboMessage {
    private MessageParams params;
    public MessageParams getParams() { return params; }
    public void setParams(MessageParams setterArg) { this.params = setterArg; }

    private byte[] data;
    public byte[] getData() { return data; }
    public void setData(byte[] setterArg) { this.data = setterArg; }

    Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("params", params.toMap());
      toMapResult.put("data", data);
      return toMapResult;
    }
    static MesiboMessage fromMap(Map<String, Object> map) {
      MesiboMessage fromMapResult = new MesiboMessage();
      Object params = map.get("params");
      fromMapResult.params = MessageParams.fromMap((Map)params);
      Object data = map.get("data");
      fromMapResult.data = (byte[])data;
      return fromMapResult;
    }
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter.*/
  public interface MesiboRealTimeApi {
    void setAccessToken(SetAccessTokenCommand arg);
    void start();
    ChatHistoryResult loadChatHistory(LoadChatHistoryCommand arg);
    ChatSummaryResult loadChatSummary(LoadChatSummaryCommand arg);
    SendMessageResult sendMessage(SendMessageCommand arg);
    void launchBuiltInChatUI();

    /** Sets up an instance of `MesiboRealTimeApi` to handle messages through the `binaryMessenger`. */
    static void setup(BinaryMessenger binaryMessenger, MesiboRealTimeApi api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.MesiboRealTimeApi.setAccessToken", new StandardMessageCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              @SuppressWarnings("ConstantConditions")
              SetAccessTokenCommand input = SetAccessTokenCommand.fromMap((Map<String, Object>)message);
              api.setAccessToken(input);
              wrapped.put("result", null);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.MesiboRealTimeApi.start", new StandardMessageCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              api.start();
              wrapped.put("result", null);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.MesiboRealTimeApi.loadChatHistory", new StandardMessageCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              @SuppressWarnings("ConstantConditions")
              LoadChatHistoryCommand input = LoadChatHistoryCommand.fromMap((Map<String, Object>)message);
              ChatHistoryResult output = api.loadChatHistory(input);
              wrapped.put("result", output.toMap());
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.MesiboRealTimeApi.loadChatSummary", new StandardMessageCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              @SuppressWarnings("ConstantConditions")
              LoadChatSummaryCommand input = LoadChatSummaryCommand.fromMap((Map<String, Object>)message);
              ChatSummaryResult output = api.loadChatSummary(input);
              wrapped.put("result", output.toMap());
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.MesiboRealTimeApi.sendMessage", new StandardMessageCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              @SuppressWarnings("ConstantConditions")
              SendMessageCommand input = SendMessageCommand.fromMap((Map<String, Object>)message);
              SendMessageResult output = api.sendMessage(input);
              wrapped.put("result", output.toMap());
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.MesiboRealTimeApi.launchBuiltInChatUI", new StandardMessageCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              api.launchBuiltInChatUI();
              wrapped.put("result", null);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
    }
  }

  /** Generated class from Pigeon that represents Flutter messages that can be called from Java.*/
  public static class MesiboConnectionListener {
    private final BinaryMessenger binaryMessenger;
    public MesiboConnectionListener(BinaryMessenger argBinaryMessenger){
      this.binaryMessenger = argBinaryMessenger;
    }
    public interface Reply<T> {
      void reply(T reply);
    }
    public void onConnectionStatus(ConnectionStatus argInput, Reply<Void> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.MesiboConnectionListener.onConnectionStatus", new StandardMessageCodec());
      Map<String, Object> inputMap = argInput.toMap();
      channel.send(inputMap, channelReply -> {
        callback.reply(null);
      });
    }
  }

  /** Generated class from Pigeon that represents Flutter messages that can be called from Java.*/
  public static class MesiboMessageListener {
    private final BinaryMessenger binaryMessenger;
    public MesiboMessageListener(BinaryMessenger argBinaryMessenger){
      this.binaryMessenger = argBinaryMessenger;
    }
    public interface Reply<T> {
      void reply(T reply);
    }
    public void onMessage(MesiboMessage argInput, Reply<Void> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.MesiboMessageListener.onMessage", new StandardMessageCodec());
      Map<String, Object> inputMap = argInput.toMap();
      channel.send(inputMap, channelReply -> {
        callback.reply(null);
      });
    }
    public void onMessageStatus(MessageParams argInput, Reply<Void> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.MesiboMessageListener.onMessageStatus", new StandardMessageCodec());
      Map<String, Object> inputMap = argInput.toMap();
      channel.send(inputMap, channelReply -> {
        callback.reply(null);
      });
    }
  }
  private static Map<String, Object> wrapError(Throwable exception) {
    Map<String, Object> errorMap = new HashMap<>();
    errorMap.put("message", exception.toString());
    errorMap.put("code", exception.getClass().getSimpleName());
    errorMap.put("details", null);
    return errorMap;
  }
}