import 'dart:ui';

import 'package:native_virtual_keyboard/src/view/keyboard_theme.dart';

final class Ios26KeyboardThemeLight extends KeyboardTheme {
  Ios26KeyboardThemeLight({
    super.backgroundColor = const Color(0xFFA1ADD1),
    super.topBorderColor = const Color(0xFFDEEFFA),
    super.keyTheme = const KeyboardKeyTheme(
      backgroundColor: Color(0xFFE8F0FF),
      pressedBackgroundColor: Color(0xFFF7FCFF),
      foregroundColor: Color(0xFF000000),
    ),
    super.specialKeyTheme = const KeyboardSpecialKeyTheme(
      backgroundColor: Color(0xFFE8F0FF),
      foregroundColor: Color(0xFF000000),
      pressedBackgroundColor: Color(0xFFACB7D9),
      pressedOverlayColor: null,
      pressedFillIcon: true,
    ),
  });

  @override
  Ios26KeyboardThemeLight copyWith({
    Color? backgroundColor,
    Color? topBorderColor,
    KeyboardKeyTheme? keyTheme,
    KeyboardSpecialKeyTheme? specialKeyTheme,
  }) {
    return Ios26KeyboardThemeLight(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      topBorderColor: topBorderColor ?? this.topBorderColor,
      keyTheme: keyTheme ?? this.keyTheme,
      specialKeyTheme: specialKeyTheme ?? this.specialKeyTheme,
    );
  }
}

final class Ios26KeyboardThemeDark extends KeyboardTheme {
  Ios26KeyboardThemeDark({
    super.backgroundColor = const Color(0xFF17203F),
    super.topBorderColor = const Color(0xFF2F4AA1),
    super.keyTheme = const KeyboardKeyTheme(
      backgroundColor: Color(0xFF3D445B),
      pressedBackgroundColor: Color(0xFF53596C),
      foregroundColor: Color(0xFFFFFFFF),
    ),
    super.specialKeyTheme = const KeyboardSpecialKeyTheme(
      backgroundColor: Color(0xFF3D445B),
      foregroundColor: Color(0xFFFFFFFF),
      pressedBackgroundColor: Color(0xFF262E4A),
      pressedOverlayColor: null,
      pressedFillIcon: true,
    ),
  });

  @override
  Ios26KeyboardThemeDark copyWith({
    Color? backgroundColor,
    Color? topBorderColor,
    KeyboardKeyTheme? keyTheme,
    KeyboardSpecialKeyTheme? specialKeyTheme,
  }) {
    return Ios26KeyboardThemeDark(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      topBorderColor: topBorderColor ?? this.topBorderColor,
      keyTheme: keyTheme ?? this.keyTheme,
      specialKeyTheme: specialKeyTheme ?? this.specialKeyTheme,
    );
  }
}
