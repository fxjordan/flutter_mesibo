import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_mesibo/mesibo.dart';
import 'package:flutter_mesibo/mesibo_binding.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: MesiboTestContent(),
      ),
    );
  }
}

/// We need to wrap the test in a separate widget so the 'prompt' method can access
/// a BuildContext with a reference to a MaterialApp.
class MesiboTestContent extends StatefulWidget {
  @override
  _MesiboTestContentState createState() => _MesiboTestContentState();
}

class _MesiboTestContentState extends State<MesiboTestContent> {
  List<String> _logs = ['- Trying to start Mesibo -'];

  bool _mesiboInitialized = false;
  UserProfile _selfProfile;
  List<UserProfile> _recentProfiles;

  /// Called after user pasted an access token into our prompt and hit 'start' button
  Future<void> initMesibo(String accessToken) async {
    if (_mesiboInitialized) {
      throw Exception('Mesibo already initialized!');
    }
    // Get Mesibo instance
    Mesibo mesibo = Mesibo.instance;

    // 1. set a users access token

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      // TODO Implement returning of result (may fail without exception)
      await mesibo.setAccessToken(accessToken);
    } on PlatformException catch (e) {
      setState(() {
        _logs.add('Failed to set access token: ${e.message}');
      });
      return;
    }
    setState(() {
      _logs.add('setAccess token successfully');
    });

    // 2. Start Mesibo
    try {
      // TODO Implement returning of result (may fail without exception)
      await mesibo.start();
    } on PlatformException catch (e) {
      setState(() {
        _logs.add('Failed to start Mesibo!: ${e.message}');
      });
      return;
    }
    setState(() {
      _logs.add('started Mesibo successfully');
      _mesiboInitialized = true;
    });

    /*
    UserProfile selfProfile = await mesibo.getSelfProfile();
    print('loaded self profile: $selfProfile');
    setState(() {
      _selfProfile = selfProfile;
    });*/

    /*
     * Listen for incoming messages.
     *
     * You can send a text message from the Mesibo console to the user
     * from which you copied the access token.
     */
    mesibo.realTimeMessageStream.listen(_handleNewMessage);

    // listen for connection status changes
    mesibo.connectionStatusStream.listen(_handleConnectionStatusChanged);
  }

  /*
   * Adds a received real time message to the output
   */
  void _handleNewMessage(MesiboMessage message) {
    // read message data as string
    final messageText = utf8.decode(message.data);

    setState(() {
      _logs.add('new message (peer=${message.params.peer}): $messageText');
    });
  }

  void _handleConnectionStatusChanged(int status) {
    setState(() {
      _logs.add('connection status changed: $status');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          color: Theme.of(context).primaryColor,
          child: Text('Add token and start Mesibo'),
          onPressed: () async {
            if (_mesiboInitialized) {
              setState(() {
                _logs.add('Mesibo already initialized');
              });
              return;
            }

            String accessToken = await prompt(
              context,
              title: Text('Access Token'),
              hintText:
                  'Input a Mesibo access token for an existing user (copy from Mesibo console)',
              textOK: Text('Start Mesibo'),
            );
            if (accessToken != null && accessToken.isNotEmpty) {
              setState(() {
                _logs.add('initializing');
              });
              initMesibo(accessToken);
            } else {
              setState(() {
                _logs.add('no access token given');
              });
            }
          },
        ),
        MaterialButton(
          child: Text('Stop Mesibo'),
          onPressed: () async {
            await Mesibo.instance.stop();
            setState(() {
              _logs.add('Sopped Mesibo');
            });
          },
        ),
        MaterialButton(
          child: Text('Start (again)'),
          onPressed: () async {
            await Mesibo.instance.start();
            setState(() {
              _logs.add('Started Mesibo');
            });
          },
        ),
        MaterialButton(
          child: Text('Load recent profiles'),
          onPressed: () async {
            List<UserProfile> profiles =
                await Mesibo.instance.getRecentProfiles();
            print('loaded ${profiles.length} profiles');
            setState(() {
              _recentProfiles = profiles;
            });
          },
        ),
        _selfProfile != null
            ? Text(
                'user profile: address=${_selfProfile.address}, name=${_selfProfile.name}, unreadCount=${_selfProfile.unread}')
            : Container(),
        Text('Recent profiles:'),
        _recentProfiles != null
            ? Column(
                children: _recentProfiles
                    .map((profile) =>
                        Text('${profile.name} (unread: ${profile.unread})'))
                    .toList())
            : Text('-'),
        Expanded(
          child: Center(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _logs
                      .map((text) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text(text),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
