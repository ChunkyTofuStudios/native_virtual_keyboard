import 'package:flutter/material.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_theme.dart';

final class AndroidKeyboardThemeLight extends KeyboardTheme {
  AndroidKeyboardThemeLight()
    : super(
        backgroundColor: const Color(0xFFEEEDF6),
        topBorderColor: null,
        keyTheme: const KeyboardKeyTheme(
          backgroundColor: Color(0xFFFFFFFF),
          pressedBackgroundColor: Color(0xFFEEEDF6),
          foregroundColor: Color(0xFF30323B),
        ),
        specialKeyTheme: const KeyboardSpecialKeyTheme(
          backgroundColor: Color(0xFFDDE2F9),
          foregroundColor: Color(0xFF4B5164),
          pressedBackgroundColor: Color(0xFFDDE2F9),
          pressedOverlayColor: Colors.black12,
          pressedFillIcon: false,
        ),
      );
}

final class AndroidKeyboardThemeDark extends KeyboardTheme {
  AndroidKeyboardThemeDark()
    : super(
        backgroundColor: const Color(0xFF181920),
        topBorderColor: null,
        keyTheme: const KeyboardKeyTheme(
          backgroundColor: Color(0xFF23252E),
          pressedBackgroundColor: Color(0xFF181920),
          foregroundColor: Color(0xFFE4E5F0),
        ),
        specialKeyTheme: const KeyboardSpecialKeyTheme(
          backgroundColor: Color(0xFF353B4D),
          foregroundColor: Color(0xFFB9BED5),
          pressedBackgroundColor: Color(0xFF353B4D),
          pressedOverlayColor: Colors.white12,
          pressedFillIcon: false,
        ),
      );
}
