import 'dart:developer';

import 'package:flutter/services.dart';

class KeyguardHelper {
  static const MethodChannel _channel =
      MethodChannel('com.quoppo.quirloe/keyguard');
  static Future<void> disableKeyguard() async {
    try {
      await _channel.invokeMethod('disableKeyguard');
    } on PlatformException catch (e) {
      log("Failed to disable keyguard: ${e.message}");
    }
  }

  static Future<void> enableKeyguard() async {
    try {
      await _channel.invokeMethod('enableKeyguard');
    } on PlatformException catch (e) {
      log("Failed to enable keyguard: ${e.message}");
    }
  }
}
