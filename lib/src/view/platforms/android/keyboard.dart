import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_dimensions.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_theme.dart';
import 'package:native_virtual_keyboard/src/view/platforms/android/dimensions.dart';
import 'package:native_virtual_keyboard/src/view/platforms/android/theme.dart';
import 'package:native_virtual_keyboard/src/view/platforms/base_keyboard.dart';

final class AndroidKeyboard extends BaseKeyboard {
  const AndroidKeyboard({
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
      Brightness.light => AndroidKeyboardThemeLight(),
      Brightness.dark => AndroidKeyboardThemeDark(),
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
      color: params.theme.keyTheme.backgroundColor,
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
            style:
                (params.controller.overlayTextTheme ??
                        TextTheme.of(context).bodyLarge)
                    ?.copyWith(
                      color: params.theme.keyTheme.foregroundColor,
                      fontSize: 32,
                    ),
            maxLines: 1,
            minFontSize: 4,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
