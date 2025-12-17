import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:native_virtual_keyboard/gen/assets.gen.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_dimensions.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_theme.dart';
import 'package:native_virtual_keyboard/src/view/platforms/base_keyboard.dart';
import 'package:native_virtual_keyboard/src/view/platforms/ios_26/dimensions.dart';
import 'package:native_virtual_keyboard/src/view/platforms/ios_26/theme.dart';

final class Ios26Keyboard extends BaseKeyboard {
  const Ios26Keyboard({
    super.key,
    required super.controller,
    super.backgroundColor,
    super.keyColor,
    super.keyTextStyle,
    super.keyIconColor,
    super.specialKeyColor,
    super.showEnter,
    super.showBackspace,
    super.keyShadow,
    super.keyInnerShadow,
    super.specialKeyWidthMultiplier,
  });

  @override
  KeyboardTheme getTheme(Brightness brightness) {
    return switch (brightness) {
      Brightness.light => Ios26KeyboardThemeLight(),
      Brightness.dark => Ios26KeyboardThemeDark(),
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
                style: TextTheme.of(context).bodyLarge?.copyWith(
                  color: params.theme.keyTheme.foregroundColor,
                  fontSize: 32,
                ),
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
