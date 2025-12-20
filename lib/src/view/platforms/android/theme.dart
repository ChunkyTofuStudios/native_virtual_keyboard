import 'package:flutter/material.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_theme.dart';

final class AndroidKeyboardThemeLight extends KeyboardTheme {
  AndroidKeyboardThemeLight({
    super.backgroundColor = const Color(0xFFEEEDF6),
    super.topBorderColor,
    super.keyTheme = const KeyboardKeyTheme(
      backgroundColor: Color(0xFFFFFFFF),
      pressedBackgroundColor: Color(0xFFEEEDF6),
      foregroundColor: Color(0xFF30323B),
    ),
    super.specialKeyTheme = const KeyboardSpecialKeyTheme(
      backgroundColor: Color(0xFFDDE2F9),
      foregroundColor: Color(0xFF4B5164),
      pressedBackgroundColor: Color(0xFFDDE2F9),
      pressedOverlayColor: Colors.black12,
      pressedFillIcon: false,
    ),
  });

  @override
  AndroidKeyboardThemeLight copyWith({
    Color? backgroundColor,
    Color? topBorderColor,
    KeyboardKeyTheme? keyTheme,
    KeyboardSpecialKeyTheme? specialKeyTheme,
  }) {
    return AndroidKeyboardThemeLight(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      topBorderColor: topBorderColor ?? this.topBorderColor,
      keyTheme: keyTheme ?? this.keyTheme,
      specialKeyTheme: specialKeyTheme ?? this.specialKeyTheme,
    );
  }
}

final class AndroidKeyboardThemeDark extends KeyboardTheme {
  AndroidKeyboardThemeDark({
    super.backgroundColor = const Color(0xFF181920),
    super.topBorderColor,
    super.keyTheme = const KeyboardKeyTheme(
      backgroundColor: Color(0xFF23252E),
      pressedBackgroundColor: Color(0xFF181920),
      foregroundColor: Color(0xFFE4E5F0),
    ),
    super.specialKeyTheme = const KeyboardSpecialKeyTheme(
      backgroundColor: Color(0xFF353B4D),
      foregroundColor: Color(0xFFB9BED5),
      pressedBackgroundColor: Color(0xFF353B4D),
      pressedOverlayColor: Colors.white12,
      pressedFillIcon: false,
    ),
  });

  @override
  AndroidKeyboardThemeDark copyWith({
    Color? backgroundColor,
    Color? topBorderColor,
    KeyboardKeyTheme? keyTheme,
    KeyboardSpecialKeyTheme? specialKeyTheme,
  }) {
    return AndroidKeyboardThemeDark(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      topBorderColor: topBorderColor ?? this.topBorderColor,
      keyTheme: keyTheme ?? this.keyTheme,
      specialKeyTheme: specialKeyTheme ?? this.specialKeyTheme,
    );
  }
}
