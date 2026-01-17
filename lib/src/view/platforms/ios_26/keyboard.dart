import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:native_virtual_keyboard/gen/assets.gen.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_dimensions.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_theme.dart';
import 'package:native_virtual_keyboard/src/view/platforms/base_keyboard.dart';
import 'package:native_virtual_keyboard/src/view/platforms/ios_26/dimensions.dart';

final class Ios26Keyboard extends BaseKeyboard {
  const Ios26Keyboard({
    super.key,
    required super.controller,
    super.theme,
    super.showEnter,
    super.showBackspace,
    super.specialKeyWidthMultiplier,
  });

  static const lightTheme = KeyboardTheme(
    backgroundColor: Color(0xFFA1ADD1),
    topBorderColor: Color(0xFFDEEFFA),
    keyTheme: KeyboardKeyTheme(
      backgroundColor: Color(0xFFE8F0FF),
      pressedBackgroundColor: Color(0xFFF7FCFF),
      foregroundColor: Color(0xFF000000),
    ),
    specialKeyTheme: KeyboardSpecialKeyTheme(
      backgroundColor: Color(0xFFE8F0FF),
      foregroundColor: Color(0xFF000000),
      pressedBackgroundColor: Color(0xFFACB7D9),
      pressedOverlayColor: null,
      pressedFillIcon: true,
    ),
  );

  static const darkTheme = KeyboardTheme(
    backgroundColor: Color(0xFF17203F),
    topBorderColor: Color(0xFF2F4AA1),
    keyTheme: KeyboardKeyTheme(
      backgroundColor: Color(0xFF3D445B),
      pressedBackgroundColor: Color(0xFF53596C),
      foregroundColor: Color(0xFFFFFFFF),
    ),
    specialKeyTheme: KeyboardSpecialKeyTheme(
      backgroundColor: Color(0xFF3D445B),
      foregroundColor: Color(0xFFFFFFFF),
      pressedBackgroundColor: Color(0xFF262E4A),
      pressedOverlayColor: null,
      pressedFillIcon: true,
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
    return Ios26KeyboardDimensionsConfig();
  }

  @override
  OverlayFollowerBuilder overlayFollowerBuilder() {
    return (context, layerLink, params) => CompositedTransformFollower(
      link: layerLink,
      showWhenUnlinked: false,
      targetAnchor: Alignment.bottomCenter,
      followerAnchor: Alignment.bottomCenter,
      offset: Offset(0, -params.padding.vertical / 2),
      child: _KeyPressOverlay(params: params),
    );
  }
}

class _KeyPressOverlay extends StatelessWidget {
  final KeyParams params;

  const _KeyPressOverlay({required this.params});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Assets.images.ios26KeyPressedOverlay.svg(
          colorFilter: ColorFilter.mode(
            params.theme.keyTheme.overlayBackgroundColor ??
                params.theme.keyTheme.pressedBackgroundColor,
            BlendMode.srcIn,
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: params.overlaySize.width * 0.4,
            height: params.overlaySize.height * 0.52,
            child: FittedBox(
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
        ),
      ],
    );
  }
}