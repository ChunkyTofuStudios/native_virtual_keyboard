import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:native_virtual_keyboard/src/extensions/ios_version_infos.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_platform.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_theme.dart';
import 'package:native_virtual_keyboard/src/view/platforms/android/keyboard.dart';
import 'package:native_virtual_keyboard/src/view/platforms/ios_18/keyboard.dart';
import 'package:native_virtual_keyboard/src/view/platforms/ios_26/keyboard.dart';
import 'package:native_virtual_keyboard/src/view/virtual_keyboard_controller.dart';

/// A virtual keyboard widget that mimics native iOS and Android keyboards.
///
/// Use [theme] to customize the appearance. Pre-built themes are available:
/// - [KeyboardTheme.androidLight] / [KeyboardTheme.androidDark]
/// - [KeyboardTheme.ios18Light] / [KeyboardTheme.ios18Dark]
/// - [KeyboardTheme.ios26Light] / [KeyboardTheme.ios26Dark]
///
/// For custom themes, create a new [KeyboardTheme] instance.
final class VirtualKeyboard extends StatelessWidget {
  static final _log = Logger('VirtualKeyboard');

  /// Force a specific platform. If not provided, the platform will be detected automatically.
  final KeyboardPlatform? platform;

  /// The controller for the keyboard.
  final VirtualKeyboardController controller;

  /// Complete theme for the keyboard.
  /// If not provided, the default platform theme will be used.
  final KeyboardTheme? theme;

  /// Multiplier for the width of special keys.
  final double? specialKeyWidthMultiplier;

  /// Whether to show the enter key.
  final bool showEnter;

  /// Whether to show the backspace key.
  final bool showBackspace;

  const VirtualKeyboard({
    super.key,
    required this.controller,
    this.platform,
    this.theme,
    this.specialKeyWidthMultiplier,
    this.showEnter = true,
    this.showBackspace = true,
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
        final effectivePlatform = _getPlatform(snapshot.data);
        _log.fine('Platform identified as: ${effectivePlatform.name}');
        return switch (effectivePlatform) {
          KeyboardPlatform.android => AndroidKeyboard(
            controller: controller,
            theme: theme,
            showEnter: showEnter,
            showBackspace: showBackspace,
            specialKeyWidthMultiplier: specialKeyWidthMultiplier,
          ),
          KeyboardPlatform.ios18 => Ios18Keyboard(
            controller: controller,
            theme: theme,
            showEnter: showEnter,
            showBackspace: showBackspace,
            specialKeyWidthMultiplier: specialKeyWidthMultiplier,
          ),
          KeyboardPlatform.ios26 => Ios26Keyboard(
            controller: controller,
            theme: theme,
            showEnter: showEnter,
            showBackspace: showBackspace,
            specialKeyWidthMultiplier: specialKeyWidthMultiplier,
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
