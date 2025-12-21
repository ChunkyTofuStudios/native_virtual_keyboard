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

  /// Creates a copy of this theme with the given fields replaced.
  KeyboardTheme copyWith({
    Color? backgroundColor,
    Color? topBorderColor,
    KeyboardKeyTheme? keyTheme,
    KeyboardSpecialKeyTheme? specialKeyTheme,
  });
}

final class KeyboardKeyTheme {
  /// The color of the keys.
  final Color backgroundColor;

  /// The color of the keys when they are pressed.
  final Color pressedBackgroundColor;

  /// The color of the text.
  final Color foregroundColor;

  /// The shadows of the keys.
  final List<BoxShadow>? shadows;

  /// The inner shadows of the keys.
  final List<BoxShadow>? innerShadows;

  const KeyboardKeyTheme({
    required this.backgroundColor,
    required this.pressedBackgroundColor,
    required this.foregroundColor,
    this.shadows,
    this.innerShadows,
  });

  KeyboardKeyTheme copyWith({
    Color? backgroundColor,
    Color? pressedBackgroundColor,
    Color? foregroundColor,
    List<BoxShadow>? shadows,
    List<BoxShadow>? innerShadows,
  }) {
    return KeyboardKeyTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      pressedBackgroundColor:
          pressedBackgroundColor ?? this.pressedBackgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      shadows: shadows ?? this.shadows,
      innerShadows: innerShadows ?? this.innerShadows,
    );
  }
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
    super.shadows,
    super.innerShadows,
    required this.pressedOverlayColor,
    required this.pressedFillIcon,
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
    );
  }
}
