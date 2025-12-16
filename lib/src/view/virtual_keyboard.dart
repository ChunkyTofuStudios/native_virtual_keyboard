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

  /// The background color of the keyboard.
  final Color? backgroundColor;

  /// The color of the keys.
  final Color? keyColor;

  /// The text style of the keys.
  final TextStyle? keyTextStyle;

  /// The text theme to use for the keyboard.
  final TextTheme? textTheme;

  /// The color of the icons on the keys.
  final Color? keyIconColor;

  const VirtualKeyboard({
    super.key,
    this.platform,
    required this.controller,
    this.backgroundColor,
    this.keyColor,
    this.keyTextStyle,
    this.textTheme,
    this.keyIconColor,
  });

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
          KeyboardPlatform.android => AndroidKeyboard(
            controller: controller,
            backgroundColor: backgroundColor,
            keyColor: keyColor,
            keyTextStyle: keyTextStyle,
            textTheme: textTheme,
            keyIconColor: keyIconColor,
          ),
          KeyboardPlatform.ios18 => Ios18Keyboard(
            controller: controller,
            backgroundColor: backgroundColor,
            keyColor: keyColor,
            keyTextStyle: keyTextStyle,
            textTheme: textTheme,
            keyIconColor: keyIconColor,
          ),
          KeyboardPlatform.ios26 => Ios26Keyboard(
            controller: controller,
            backgroundColor: backgroundColor,
            keyColor: keyColor,
            keyTextStyle: keyTextStyle,
            textTheme: textTheme,
            keyIconColor: keyIconColor,
          ),
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
