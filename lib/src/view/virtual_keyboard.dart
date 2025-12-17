import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:native_virtual_keyboard/src/view/platforms/android/keyboard.dart';
import 'package:native_virtual_keyboard/src/view/platforms/ios_18/keyboard.dart';
import 'package:native_virtual_keyboard/src/view/platforms/ios_26/keyboard.dart';
import 'package:native_virtual_keyboard/src/view/virtual_keyboard_controller.dart';
import 'package:native_virtual_keyboard/src/view/virtual_keyboard_theme.dart';

enum VirtualKeyboardPlatform {
  android,
  ios18,
  ios26;

  static VirtualKeyboardPlatform get autoHelper {
    final platform = defaultTargetPlatform;
    return switch (platform) {
      TargetPlatform.android || TargetPlatform.fuchsia => android,
      TargetPlatform.iOS || TargetPlatform.macOS => ios26,
      _ => android,
    };
  }
}

class VirtualKeyboard extends StatelessWidget {
  /// Force a specific platform. If not provided, the platform will be detected automatically.
  final VirtualKeyboardPlatform? platform;

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

  /// The background color of the special keys.
  final Color? specialKeyColor;

  /// Whether to show the enter key.
  final bool? showEnter;

  /// Whether to show the backspace key.
  final bool? showBackspace;

  /// The shadows of the keys.
  final List<BoxShadow>? keyShadow;

  /// The inner shadows of the keys.
  final List<BoxShadow>? keyInnerShadow;
  
  /// Multiplier for the width of special keys.
  final double? specialKeyWidthMultiplier;

  const VirtualKeyboard({
    super.key,
    required this.controller,
    this.platform,
    this.backgroundColor,
    this.keyColor,
    this.keyIconColor,
    this.specialKeyColor,
    this.keyTextStyle,
    this.textTheme,
    this.showEnter,
    this.showBackspace,
    this.keyShadow,
    this.keyInnerShadow,
    this.specialKeyWidthMultiplier,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VirtualKeyboardTheme.of(context);
    
    // Resolve values: Widget Param > Theme Param > Null (Default handles later)
    final effectiveShowEnter = showEnter ?? theme?.showEnter ?? true;
    final effectiveShowBackspace = showBackspace ?? theme?.showBackspace ?? true;
    final effectivePlatform = platform ?? VirtualKeyboardPlatform.autoHelper;

    return switch (effectivePlatform) {
       VirtualKeyboardPlatform.android => AndroidKeyboard(
            controller: controller,
            backgroundColor: backgroundColor ?? theme?.backgroundColor,
            keyColor: keyColor ?? theme?.keyColor,
            keyTextStyle: keyTextStyle ?? theme?.keyTextStyle,
            textTheme: textTheme,
            keyIconColor: keyIconColor ?? theme?.keyIconColor,
            specialKeyColor: specialKeyColor ?? theme?.specialKeyColor,
            showEnter: effectiveShowEnter,
            showBackspace: effectiveShowBackspace,
            keyShadow: keyShadow ?? theme?.keyShadow,
            keyInnerShadow: keyInnerShadow ?? theme?.keyInnerShadow,
            specialKeyWidthMultiplier: specialKeyWidthMultiplier ?? theme?.specialKeyWidthMultiplier,
          ),
      VirtualKeyboardPlatform.ios18 => Ios18Keyboard(
            controller: controller,
            backgroundColor: backgroundColor ?? theme?.backgroundColor,
            keyColor: keyColor ?? theme?.keyColor,
            keyTextStyle: keyTextStyle ?? theme?.keyTextStyle,
            textTheme: textTheme,
            keyIconColor: keyIconColor ?? theme?.keyIconColor,
            specialKeyColor: specialKeyColor ?? theme?.specialKeyColor,
            showEnter: effectiveShowEnter,
            showBackspace: effectiveShowBackspace,
            keyShadow: keyShadow ?? theme?.keyShadow,
            keyInnerShadow: keyInnerShadow ?? theme?.keyInnerShadow,
            specialKeyWidthMultiplier: specialKeyWidthMultiplier ?? theme?.specialKeyWidthMultiplier,
          ),
      VirtualKeyboardPlatform.ios26 => Ios26Keyboard(
            controller: controller,
            backgroundColor: backgroundColor ?? theme?.backgroundColor,
            keyColor: keyColor ?? theme?.keyColor,
            keyTextStyle: keyTextStyle ?? theme?.keyTextStyle,
            textTheme: textTheme,
            keyIconColor: keyIconColor ?? theme?.keyIconColor,
            specialKeyColor: specialKeyColor ?? theme?.specialKeyColor,
            showEnter: effectiveShowEnter,
            showBackspace: effectiveShowBackspace,
            keyShadow: keyShadow ?? theme?.keyShadow,
            keyInnerShadow: keyInnerShadow ?? theme?.keyInnerShadow,
            specialKeyWidthMultiplier: specialKeyWidthMultiplier ?? theme?.specialKeyWidthMultiplier,
          ),
    };
  }
}
