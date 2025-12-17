import 'package:native_virtual_keyboard/src/view/keyboard_dimensions.dart';

final class AndroidKeyboardDimensionsConfig extends KeyboardDimensionsConfig {
  AndroidKeyboardDimensionsConfig()
    : super(
        keyMaxScreenWidth: (1080 - 2 * 12) / 1080,
        keyGapWidthRatio: 14 / 93,
        keyAspectRatio: 93 / 123,
        keyBorderRadiusWidthRatio: 19 / 93,
        specialKeyWidthMultiplier: 147 / 93,
        horzToVertSpacingRatio: 14 / 31,
        overlayWidthToWidthRatio: 152 / 93,
        overlayAspectRatio: 1,
        keyElevation: 0,
        topPaddingToWidthRatio: 35 / 93,
        topBorderRadiusWidthRatio: 0,
      );
}
