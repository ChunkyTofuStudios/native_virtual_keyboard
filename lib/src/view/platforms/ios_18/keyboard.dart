import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:native_virtual_keyboard/gen/assets.gen.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_dimensions.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_theme.dart';
import 'package:native_virtual_keyboard/src/view/platforms/base_keyboard.dart';
import 'package:native_virtual_keyboard/src/view/platforms/ios_18/dimensions.dart';
import 'package:native_virtual_keyboard/src/view/shadex.dart';

final class Ios18Keyboard extends BaseKeyboard {
  const Ios18Keyboard({
    super.key,
    required super.controller,
    super.theme,
    super.showEnter,
    super.showBackspace,
    super.specialKeyWidthMultiplier,
  });

  static const lightTheme = KeyboardTheme(
    backgroundColor: Color(0xFFC8CFE1),
    topBorderColor: Color(0xFFCBD8FA),
    keyTheme: KeyboardKeyTheme(
      backgroundColor: Color(0xFFFFFFFF),
      pressedBackgroundColor: Color(0xFFFFFFFF),
      foregroundColor: Color(0xFF000000),
    ),
    specialKeyTheme: KeyboardSpecialKeyTheme(
      backgroundColor: Color(0xFF9AA7C7),
      foregroundColor: Color(0xFF00010E),
      pressedBackgroundColor: Color(0xFFFFFFFF),
      pressedOverlayColor: null,
      pressedFillIcon: true,
    ),
  );

  static const darkTheme = KeyboardTheme(
    backgroundColor: Color(0xFF333333),
    topBorderColor: Color(0xFF242424),
    keyTheme: KeyboardKeyTheme(
      backgroundColor: Color(0xFF707070),
      pressedBackgroundColor: Color(0xFF707070),
      foregroundColor: Color(0xFFFFFFFF),
    ),
    specialKeyTheme: KeyboardSpecialKeyTheme(
      backgroundColor: Color(0xFF4C4C4C),
      foregroundColor: Color(0xFFFFFFFF),
      pressedBackgroundColor: Color(0xFF696A6C),
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
    return Ios18KeyboardDimensionsConfig();
  }

  @override
  OverlayFollowerBuilder overlayFollowerBuilder() {
    return (context, layerLink, params) => CompositedTransformFollower(
      link: layerLink,
      showWhenUnlinked: false,
      targetAnchor: Alignment.bottomCenter,
      followerAnchor: Alignment.bottomCenter,
      offset: Offset(0, -params.padding.vertical / 2),
      child: _KeyPressOverlay(params: params), // Same as iOS 26
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
        Shadex(
          shadowColor: Colors.black26,
          shadowBlurRadius: 9,
          shadowOffset: Offset.zero,
          child: Assets.images.ios18KeyPressedOverlay.svg(
            colorFilter: ColorFilter.mode(
              params.theme.keyTheme.overlayBackgroundColor ??
                  params.theme.keyTheme.pressedBackgroundColor,
              BlendMode.srcIn,
            ),
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