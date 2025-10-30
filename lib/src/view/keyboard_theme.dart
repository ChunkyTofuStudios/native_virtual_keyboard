import 'package:flutter/material.dart';

abstract class KeyboardTheme {
  /// The background color of the keyboard.
  final Color backgroundColor;

  /// The color of the top border of the keyboard (if any).
  /// If this is set, the keyboard will have a very thin top border.
  final Color? topBorderColor;

  /// Theme info for individual keys.
  final KeyboardKeyTheme keyTheme;

  /// Theme info for special keys. (e.g. backspace, space, enter, etc.)
  final KeyboardSpecialKeyTheme specialKeyTheme;

  const KeyboardTheme({
    required this.backgroundColor,
    required this.topBorderColor,
    required this.keyTheme,
    required this.specialKeyTheme,
  });
}

final class KeyboardKeyTheme {
  /// The color of the keys.
  final Color backgroundColor;

  /// The color of the keys when they are pressed.
  final Color pressedBackgroundColor;

  /// The color of the text.
  final Color foregroundColor;

  const KeyboardKeyTheme({
    required this.backgroundColor,
    required this.pressedBackgroundColor,
    required this.foregroundColor,
  });
}

final class KeyboardSpecialKeyTheme extends KeyboardKeyTheme {
  /// The overlay color to use when the key is pressed.
  final Color? pressedOverlayColor;

  /// Whether to fill the icon of the special keys when they are pressed.
  final bool pressedFillIcon;

  const KeyboardSpecialKeyTheme({
    required super.backgroundColor,
    required super.pressedBackgroundColor,
    required super.foregroundColor,
    required this.pressedOverlayColor,
    required this.pressedFillIcon,
  });
}
