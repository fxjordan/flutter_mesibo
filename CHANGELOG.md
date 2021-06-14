## 0.1.3

- add `getSelfProfile()`

## 0.1.2

- Minimum iOS deployment target version is iOS 10.0
- upgraded mesibo pod dependency to 1.4.5

## 0.1.1

add `setPushToken(token)` to support push notification use cases

## 0.1.0

Initial release of basic Mesibo chat functionalities with platform specific implementations for iOS
and Android.

The following raw methods of the Mesibo real-time API are available:
* `setAccessToken(token)`
* `start()`
* `sendMessage(params, data)`

Raw Listener:
* MessageListener: `onMessage(params, data)`, `onMessageStatus(params)`
* ConnectionListener: `onConnectionStatus(statusCode)`

On top of Mesibos read sessions (which are not available in our Flutter yet) we implemented the
following methods:

* `loadChatSummary(limit)` - load first message of latest N chats
* `loadChatHistory(address, limit)` - load latest N messages of a specific chat

NOTE: The Mesibo methods listed above *can* be called directly by using the generated
`mesibo_binding.dart` file. However, this is not the recommended way. Because of the code generator
for the platform bridging code we use (Pigeon) all methods must have a specific signature which makes
it necessary to wrap all parameter in a command object and the return type in a result type.

Therefore we implemented the higher level layer in `mesibo.dart`. It wraps the command calls in methods
which are more close or equal to the methods known from the native Mesibo libraries and documentation.
Also, this layer provides more advanced Flutter specific methods and interfaces to receive methods.
For example, instead of creating a read session and waiting for the messages in a listener you can
simply use `Future<List<MesiboMessage>> loadChatHistory(address, n)` to get a list of the latest N
messages in a chat with the given address.
In addition, we provide Dart-style `Stream`s which can be subscribed by client code to receive real-time
messages and message status updates.

Release note: This initial version of the library was extracted from our company project
*The BUDDY App*, which will be moved to production soon. Therefore, we have high interest in maintaining
this Flutter plugin and are happy to receive feedback from the community.
In the future, some code needs to be refactored to be more general and usable as a common Mesibo library.
