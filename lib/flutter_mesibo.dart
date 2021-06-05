
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterMesibo {
  static const MethodChannel _channel =
      const MethodChannel('flutter_mesibo');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
