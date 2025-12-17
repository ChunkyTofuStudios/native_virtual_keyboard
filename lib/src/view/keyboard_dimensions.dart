import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_layout.dart';

final class KeyboardDimensions {
  // The amount of vertical space between the top of the keyboard and the first key.
  final double topPadding;

  /// The top border radius (top-left and top-right corners).
  final double topBorderRadius;

  /// Horizontal padding of keyboard from screen edges.
  final double horizontalPadding;

  /// Dimensions of individual keys.
  final KeyboardKeyDimensions keyDimensions;

  const KeyboardDimensions._({
    required this.topPadding,
    required this.topBorderRadius,
    required this.horizontalPadding,
    required this.keyDimensions,
  });

  factory KeyboardDimensions.compute(
    KeyboardDimensionsConfig config,
    double screenWidth,
    KeyboardLayout layout, {
    double? specialKeyWidthMultiplier,
  }) {
    final horizontalPadding = screenWidth * (1 - config.keyMaxScreenWidth) / 2;

    final keysPerRow = layout.layout.map((row) => row.length).max;
    final keyAndGapCount = (keysPerRow - 1) + (1 - config.keyGapWidthRatio);
    final keySpace = screenWidth * config.keyMaxScreenWidth / keyAndGapCount;

    final width = keySpace * (1 - config.keyGapWidthRatio);
    final height = width / config.keyAspectRatio;
    final size = Size(width, height);

    final effectiveSpecialKeyWidthMultiplier =
        specialKeyWidthMultiplier ?? config.specialKeyWidthMultiplier;
    final specialWidth = width * effectiveSpecialKeyWidthMultiplier;
    final specialSize = Size(specialWidth, height);

    final borderRadius = width * config.keyBorderRadiusWidthRatio;

    final horzSpacing = keySpace * config.keyGapWidthRatio;
    final vertSpacing = horzSpacing / config.horzToVertSpacingRatio;

    final overlayWidth = width * config.overlayWidthToWidthRatio;
    final overlaySize = Size(
      overlayWidth,
      overlayWidth / config.overlayAspectRatio,
    );

    return KeyboardDimensions._(
      topPadding: width * config.topPaddingToWidthRatio,
      topBorderRadius: width * config.topBorderRadiusWidthRatio,
      horizontalPadding: horizontalPadding,
      keyDimensions: KeyboardKeyDimensions._(
        size: size,
        specialSize: specialSize,
        borderRadius: borderRadius,
        horizontalSpacing: horzSpacing,
        verticalSpacing: vertSpacing,
        elevation: config.keyElevation,
        overlaySize: overlaySize,
      ),
    );
  }
}

final class KeyboardKeyDimensions {
  /// Size of keys.
  final Size size;

  /// Size of special keys.
  final Size specialSize;

  /// Border radius of keys.
  final double borderRadius;

  /// Horizontal spacing between keys.
  final double horizontalSpacing;

  /// Vertical spacing between keys.
  final double verticalSpacing;

  /// Elevation of keys.
  final double elevation;

  /// Size of pop-up (when the key is pressed).
  final Size overlaySize;

  const KeyboardKeyDimensions._({
    required this.size,
    required this.specialSize,
    required this.borderRadius,
    required this.horizontalSpacing,
    required this.verticalSpacing,
    required this.elevation,
    required this.overlaySize,
  });
}

abstract class KeyboardDimensionsConfig {
  final double keyMaxScreenWidth;
  final double keyGapWidthRatio;
  final double keyAspectRatio;
  final double keyBorderRadiusWidthRatio;
  final double specialKeyWidthMultiplier;
  final double horzToVertSpacingRatio;
  final double overlayWidthToWidthRatio;
  final double overlayAspectRatio;
  final double keyElevation;
  final double topPaddingToWidthRatio;
  final double topBorderRadiusWidthRatio;

  const KeyboardDimensionsConfig({
    required this.keyMaxScreenWidth,
    required this.keyGapWidthRatio,
    required this.keyAspectRatio,
    required this.keyBorderRadiusWidthRatio,
    required this.specialKeyWidthMultiplier,
    required this.horzToVertSpacingRatio,
    required this.overlayWidthToWidthRatio,
    required this.overlayAspectRatio,
    required this.keyElevation,
    required this.topPaddingToWidthRatio,
    required this.topBorderRadiusWidthRatio,
  });
}
