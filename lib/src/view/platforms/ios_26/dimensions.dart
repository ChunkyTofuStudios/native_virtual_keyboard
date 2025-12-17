import 'package:native_virtual_keyboard/gen/assets.gen.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_dimensions.dart';

final class Ios26KeyboardDimensionsConfig extends KeyboardDimensionsConfig {
  Ios26KeyboardDimensionsConfig()
    : super(
        keyMaxScreenWidth: (1206 - 26 - 25) / 1206,
        keyGapWidthRatio: 18 / 99,
        keyAspectRatio: 99 / 135,
        keyBorderRadiusWidthRatio: 24 / 99,
        specialKeyWidthMultiplier: 134 / 99,
        horzToVertSpacingRatio: 18 / 33,
        overlayWidthToWidthRatio: 1070 / 624,
        overlayAspectRatio:
            Assets.images.ios26KeyPressedOverlay.size!.width /
            Assets.images.ios26KeyPressedOverlay.size!.height,
        keyElevation: 0,
        topPaddingToWidthRatio: 72 / 99,
        topBorderRadiusWidthRatio: 78 / 99,
      );
}
