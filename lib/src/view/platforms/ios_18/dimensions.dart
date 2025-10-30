import 'package:native_virtual_keyboard/gen/assets.gen.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_dimensions.dart';

final class Ios18KeyboardDimensionsConfig extends KeyboardDimensionsConfig {
  Ios18KeyboardDimensionsConfig()
    : super(
        keyMaxScreenWidth: (738 - 2 * 7) / 738,
        keyGapWidthRatio: 10 / 64,
        keyAspectRatio: 64 / 78,
        keyBorderRadiusWidthRatio: 8 / 64,
        specialKeyWidthMultiplier: 81 / 64,
        horzToVertSpacingRatio: 10 / 18,
        overlayWidthToWidthRatio: 1070 / 623,
        overlayAspectRatio:
            Assets.images.ios18KeyPressedOverlay.size!.width /
            Assets.images.ios18KeyPressedOverlay.size!.height,
        keyElevation: 1,
        topPaddingToWidthRatio: 16 / 64,
        topBorderRadiusWidthRatio: 0,
      );
}
