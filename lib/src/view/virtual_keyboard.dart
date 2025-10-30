import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:native_virtual_keyboard/src/extensions/ios_version_infos.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_platform.dart';
import 'package:native_virtual_keyboard/src/view/platforms/android/keyboard.dart';
import 'package:native_virtual_keyboard/src/view/platforms/ios_18/keyboard.dart';
import 'package:native_virtual_keyboard/src/view/platforms/ios_26/keyboard.dart';
import 'package:native_virtual_keyboard/src/view/virtual_keyboard_controller.dart';

final class VirtualKeyboard extends StatelessWidget {
  static final _log = Logger('VirtualKeyboard');

  /// Force a specific platform. If not provided, the platform will be detected automatically.
  final KeyboardPlatform? platform;

  /// The controller for the keyboard.
  final VirtualKeyboardController controller;

  const VirtualKeyboard({super.key, this.platform, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _isIOS && platform == null
          ? DeviceInfoPlugin().iosInfo
          : Future.value(null),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox.shrink();
        }
        final platform = _getPlatform(snapshot.data);
        _log.fine('Platform identified as: ${platform.name}');
        return switch (platform) {
          KeyboardPlatform.android => AndroidKeyboard(controller: controller),
          KeyboardPlatform.ios18 => Ios18Keyboard(controller: controller),
          KeyboardPlatform.ios26 => Ios26Keyboard(controller: controller),
        };
      },
    );
  }

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  KeyboardPlatform _getPlatform(IosDeviceInfo? iosDeviceInfo) {
    final override = platform;
    if (override != null) {
      return override;
    }
    if (iosDeviceInfo != null) {
      return iosDeviceInfo.isIos26
          ? KeyboardPlatform.ios26
          : KeyboardPlatform.ios18;
    }
    return KeyboardPlatform.android;
  }
}
