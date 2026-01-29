import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_dimensions.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_theme.dart';
import 'package:native_virtual_keyboard/src/view/platforms/android/dimensions.dart';
import 'package:native_virtual_keyboard/src/view/platforms/base_keyboard.dart';

final class AndroidKeyboard extends BaseKeyboard {
  const AndroidKeyboard({
    super.key,
    required super.controller,
    super.theme,
    super.showEnter,
    super.showBackspace,
    super.specialKeyWidthMultiplier,
    super.disabledKeys,
  });

  static const lightTheme = KeyboardTheme(
    backgroundColor: Color(0xFFEEEDF6),
    keyTheme: KeyboardKeyTheme(
      backgroundColor: Color(0xFFFFFFFF),
      pressedBackgroundColor: Color(0xFFEEEDF6),
      foregroundColor: Color(0xFF30323B),
    ),
    specialKeyTheme: KeyboardSpecialKeyTheme(
      backgroundColor: Color(0xFFDDE2F9),
      foregroundColor: Color(0xFF4B5164),
      pressedBackgroundColor: Color(0xFFDDE2F9),
      pressedOverlayColor: Colors.black12,
      pressedFillIcon: false,
    ),
  );

  static const darkTheme = KeyboardTheme(
    backgroundColor: Color(0xFF181920),
    keyTheme: KeyboardKeyTheme(
      backgroundColor: Color(0xFF23252E),
      pressedBackgroundColor: Color(0xFF181920),
      foregroundColor: Color(0xFFE4E5F0),
    ),
    specialKeyTheme: KeyboardSpecialKeyTheme(
      backgroundColor: Color(0xFF353B4D),
      foregroundColor: Color(0xFFB9BED5),
      pressedBackgroundColor: Color(0xFF353B4D),
      pressedOverlayColor: Colors.white12,
      pressedFillIcon: false,
    ),
  );

  @override
  KeyboardTheme getTheme(Brightness brightness) {
    return switch (brightness) {
      Brightness.light => lightTheme,
      Brightness.dark => darkTheme,
    };
  }

  @override
  KeyboardDimensionsConfig getDimensionsConfig() {
    return AndroidKeyboardDimensionsConfig();
  }

  @override
  OverlayFollowerBuilder overlayFollowerBuilder() {
    return (context, layerLink, params) => CompositedTransformFollower(
      link: layerLink,
      showWhenUnlinked: false,
      targetAnchor: Alignment.topCenter,
      followerAnchor: Alignment.bottomCenter,
      offset: Offset(0, -params.padding.vertical / 2 + 5),
      child: _KeyPressOverlay(params: params),
    );
  }
}

class _KeyPressOverlay extends StatelessWidget {
  final KeyParams params;

  const _KeyPressOverlay({required this.params});

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          params.theme.keyTheme.overlayBackgroundColor ??
          params.theme.keyTheme.backgroundColor,
      shape: const CircleBorder(),
      elevation: 2,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: params.overlaySize.width * 0.1,
          vertical: params.overlaySize.height * 0.1,
        ),
        child: Center(
          child: AutoSizeText(
            params.key.text,
            style: TextStyle(
              color:
                  params.theme.keyTheme.overlayTextColor ??
                  params.theme.keyTheme.foregroundColor,
              fontSize: 32,
            ).merge(params.controller.overlayTextTheme),
            maxLines: 1,
            minFontSize: 4,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
