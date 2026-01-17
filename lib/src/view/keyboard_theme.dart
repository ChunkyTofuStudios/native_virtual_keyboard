import 'package:flutter/material.dart';
import 'package:native_virtual_keyboard/src/view/platforms/android/keyboard.dart';
import 'package:native_virtual_keyboard/src/view/platforms/ios_18/keyboard.dart';
import 'package:native_virtual_keyboard/src/view/platforms/ios_26/keyboard.dart';

/// Complete theme configuration for the virtual keyboard.
///
/// Use the factory constructors to get pre-built platform themes:
/// - [KeyboardTheme.androidLight] / [KeyboardTheme.androidDark]
/// - [KeyboardTheme.ios18Light] / [KeyboardTheme.ios18Dark]
/// - [KeyboardTheme.ios26Light] / [KeyboardTheme.ios26Dark]
///
/// For custom themes, create a new instance with all required parameters.
final class KeyboardTheme {
  /// The background color of the keyboard.
  final Color backgroundColor;

  /// The color of the top border of the keyboard (if any).
  /// If this is set, the keyboard will have a very thin top border.
  final Color? topBorderColor;

  /// Theme info for individual keys.
  final KeyboardKeyTheme keyTheme;

  /// Theme info for special keys. (e.g. backspace, space, enter, etc.)
  final KeyboardSpecialKeyTheme specialKeyTheme;

  /// The text style for key labels.
  final TextStyle? keyTextStyle;

  const KeyboardTheme({
    required this.backgroundColor,
    this.topBorderColor,
    required this.keyTheme,
    required this.specialKeyTheme,
    this.keyTextStyle,
  });

  // Factory constructors for pre-built themes
  // Factory constructors for pre-built themes
  factory KeyboardTheme.androidLight() => AndroidKeyboard.lightTheme;
  factory KeyboardTheme.androidDark() => AndroidKeyboard.darkTheme;
  factory KeyboardTheme.ios18Light() => Ios18Keyboard.lightTheme;
  factory KeyboardTheme.ios18Dark() => Ios18Keyboard.darkTheme;
  factory KeyboardTheme.ios26Light() => Ios26Keyboard.lightTheme;
  factory KeyboardTheme.ios26Dark() => Ios26Keyboard.darkTheme;

  KeyboardTheme copyWith({
    Color? backgroundColor,
    Color? topBorderColor,
    KeyboardKeyTheme? keyTheme,
    KeyboardSpecialKeyTheme? specialKeyTheme,
    TextStyle? keyTextStyle,
  }) {
    return KeyboardTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      topBorderColor: topBorderColor ?? this.topBorderColor,
      keyTheme: keyTheme ?? this.keyTheme,
      specialKeyTheme: specialKeyTheme ?? this.specialKeyTheme,
      keyTextStyle: keyTextStyle ?? this.keyTextStyle,
    );
  }
}

/// Theme configuration for regular keyboard keys.
final class KeyboardKeyTheme {
  /// The color of the keys.
  final Color backgroundColor;

  /// The color of the keys when they are pressed.
  final Color pressedBackgroundColor;

  /// The color of the text/icon.
  final Color foregroundColor;

  /// The shadows of the keys.
  final List<BoxShadow>? shadows;

  /// The inner shadows of the keys.
  final List<BoxShadow>? innerShadows;

  /// The background color of the key press overlay popup.
  final Color? overlayBackgroundColor;

  /// The text color of the key press overlay popup.
  final Color? overlayTextColor;

  const KeyboardKeyTheme({
    required this.backgroundColor,
    required this.pressedBackgroundColor,
    required this.foregroundColor,
    this.shadows,
    this.innerShadows,
    this.overlayBackgroundColor,
    this.overlayTextColor,
  });

  KeyboardKeyTheme copyWith({
    Color? backgroundColor,
    Color? pressedBackgroundColor,
    Color? foregroundColor,
    List<BoxShadow>? shadows,
    List<BoxShadow>? innerShadows,
    Color? overlayBackgroundColor,
    Color? overlayTextColor,
  }) {
    return KeyboardKeyTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      pressedBackgroundColor:
          pressedBackgroundColor ?? this.pressedBackgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      shadows: shadows ?? this.shadows,
      innerShadows: innerShadows ?? this.innerShadows,
      overlayBackgroundColor:
          overlayBackgroundColor ?? this.overlayBackgroundColor,
      overlayTextColor: overlayTextColor ?? this.overlayTextColor,
    );
  }
}

/// Theme configuration for special keyboard keys (backspace, enter, etc.).
final class KeyboardSpecialKeyTheme extends KeyboardKeyTheme {
  /// The overlay color to use when the key is pressed.
  final Color? pressedOverlayColor;

  /// Whether to fill the icon of the special keys when they are pressed.
  final bool pressedFillIcon;

  const KeyboardSpecialKeyTheme({
    required super.backgroundColor,
    required super.pressedBackgroundColor,
    required super.foregroundColor,
    super.shadows,
    super.innerShadows,
    required this.pressedOverlayColor,
    required this.pressedFillIcon,
    super.overlayBackgroundColor,
    super.overlayTextColor,
  });

  @override
  KeyboardSpecialKeyTheme copyWith({
    Color? backgroundColor,
    Color? pressedBackgroundColor,
    Color? foregroundColor,
    List<BoxShadow>? shadows,
    List<BoxShadow>? innerShadows,
    Color? pressedOverlayColor,
    bool? pressedFillIcon,
    Color? overlayBackgroundColor,
    Color? overlayTextColor,
  }) {
    return KeyboardSpecialKeyTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      pressedBackgroundColor:
          pressedBackgroundColor ?? this.pressedBackgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      shadows: shadows ?? this.shadows,
      innerShadows: innerShadows ?? this.innerShadows,
      pressedOverlayColor: pressedOverlayColor ?? this.pressedOverlayColor,
      pressedFillIcon: pressedFillIcon ?? this.pressedFillIcon,
      overlayBackgroundColor:
          overlayBackgroundColor ?? this.overlayBackgroundColor,
      overlayTextColor: overlayTextColor ?? this.overlayTextColor,
    );
  }
}
