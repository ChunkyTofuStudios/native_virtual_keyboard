import 'dart:ui';

import 'package:native_virtual_keyboard/src/view/keyboard_theme.dart';

final class Ios18KeyboardThemeLight extends KeyboardTheme {
  Ios18KeyboardThemeLight({
    super.backgroundColor = const Color(0xFFC8CFE1),
    super.topBorderColor = const Color(0xFFCBD8FA),
    super.keyTheme = const KeyboardKeyTheme(
      backgroundColor: Color(0xFFFFFFFF),
      pressedBackgroundColor: Color(0xFFFFFFFF),
      foregroundColor: Color(0xFF000000),
    ),
    super.specialKeyTheme = const KeyboardSpecialKeyTheme(
      backgroundColor: Color(0xFF9AA7C7),
      foregroundColor: Color(0xFF00010E),
      pressedBackgroundColor: Color(0xFFFFFFFF),
      pressedOverlayColor: null,
      pressedFillIcon: true,
    ),
  });

  @override
  Ios18KeyboardThemeLight copyWith({
    Color? backgroundColor,
    Color? topBorderColor,
    KeyboardKeyTheme? keyTheme,
    KeyboardSpecialKeyTheme? specialKeyTheme,
  }) {
    return Ios18KeyboardThemeLight(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      topBorderColor: topBorderColor ?? this.topBorderColor,
      keyTheme: keyTheme ?? this.keyTheme,
      specialKeyTheme: specialKeyTheme ?? this.specialKeyTheme,
    );
  }
}

final class Ios18KeyboardThemeDark extends KeyboardTheme {
  Ios18KeyboardThemeDark({
    super.backgroundColor = const Color(0xFF333333),
    super.topBorderColor = const Color(0xFF242424),
    super.keyTheme = const KeyboardKeyTheme(
      backgroundColor: Color(0xFF707070),
      pressedBackgroundColor: Color(0xFF707070),
      foregroundColor: Color(0xFFFFFFFF),
    ),
    super.specialKeyTheme = const KeyboardSpecialKeyTheme(
      backgroundColor: Color(0xFF4C4C4C),
      foregroundColor: Color(0xFFFFFFFF),
      pressedBackgroundColor: Color(0xFF696A6C),
      pressedOverlayColor: null,
      pressedFillIcon: true,
    ),
  });

  @override
  Ios18KeyboardThemeDark copyWith({
    Color? backgroundColor,
    Color? topBorderColor,
    KeyboardKeyTheme? keyTheme,
    KeyboardSpecialKeyTheme? specialKeyTheme,
  }) {
    return Ios18KeyboardThemeDark(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      topBorderColor: topBorderColor ?? this.topBorderColor,
      keyTheme: keyTheme ?? this.keyTheme,
      specialKeyTheme: specialKeyTheme ?? this.specialKeyTheme,
    );
  }
}
