import 'package:flutter/material.dart';

/// Pattern used for staggered key animations.
enum StaggerPattern {
  /// Keys animate left-to-right, top-to-bottom in sequential order.
  sequential,

  /// Keys on the same diagonal (row + column) animate together,
  /// creating a wave from top-left to bottom-right.
  diagonal,
}

/// Configuration for key disable/enable fade animations.
///
/// When provided to [VirtualKeyboard], keys will animate their opacity
/// when transitioning between enabled and disabled states.
@immutable
class KeyboardAnimationConfig {
  /// Duration of the fade animation.
  final Duration duration;

  /// Animation curve.
  final Curve curve;

  /// If true, keys animate with a staggered delay based on their position.
  /// If false, all keys animate simultaneously.
  final bool staggered;

  /// Delay between each key's animation start when [staggered] is true.
  final Duration staggerDelay;

  /// The stagger pattern to use when [staggered] is true.
  final StaggerPattern staggerPattern;

  const KeyboardAnimationConfig({
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.staggered = false,
    this.staggerDelay = const Duration(milliseconds: 50),
    this.staggerPattern = StaggerPattern.sequential,
  });

  static const defaultConfig = KeyboardAnimationConfig();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KeyboardAnimationConfig &&
          runtimeType == other.runtimeType &&
          duration == other.duration &&
          curve == other.curve &&
          staggered == other.staggered &&
          staggerDelay == other.staggerDelay &&
          staggerPattern == other.staggerPattern;

  @override
  int get hashCode => Object.hash(
        duration,
        curve,
        staggered,
        staggerDelay,
        staggerPattern,
      );
}
