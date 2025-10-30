import 'dart:ui';

import 'package:native_virtual_keyboard/src/view/keyboard_theme.dart';

final class Ios18KeyboardThemeLight extends KeyboardTheme {
  Ios18KeyboardThemeLight()
    : super(
        backgroundColor: const Color(0xFFC8CFE1),
        topBorderColor: const Color(0xFFCBD8FA),
        keyTheme: const KeyboardKeyTheme(
          backgroundColor: Color(0xFFFFFFFF),
          pressedBackgroundColor: Color(0xFFFFFFFF),
          foregroundColor: Color(0xFF000000),
        ),
        specialKeyTheme: const KeyboardSpecialKeyTheme(
          backgroundColor: Color(0xFF9AA7C7),
          foregroundColor: Color(0xFF00010E),
          pressedBackgroundColor: Color(0xFFFFFFFF),
          pressedOverlayColor: null,
          pressedFillIcon: true,
        ),
      );
}

final class Ios18KeyboardThemeDark extends KeyboardTheme {
  Ios18KeyboardThemeDark()
    : super(
        backgroundColor: const Color(0xFF333333),
        topBorderColor: const Color(0xFF242424),
        keyTheme: const KeyboardKeyTheme(
          backgroundColor: Color(0xFF707070),
          pressedBackgroundColor: Color(0xFF707070),
          foregroundColor: Color(0xFFFFFFFF),
        ),
        specialKeyTheme: const KeyboardSpecialKeyTheme(
          backgroundColor: Color(0xFF4C4C4C),
          foregroundColor: Color(0xFFFFFFFF),
          pressedBackgroundColor: Color(0xFF696A6C),
          pressedOverlayColor: null,
          pressedFillIcon: true,
        ),
      );
}
