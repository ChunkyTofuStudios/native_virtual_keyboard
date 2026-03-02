import 'package:equatable/equatable.dart';
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
class KeyboardAnimationConfig extends Equatable {
  /// Duration of the fade animation.
  final Duration duration;

  /// Animation curve.
  final Curve curve;

  /// The stagger pattern to use. If null, stagger animation is disabled.
  final StaggerPattern? staggerPattern;

  /// Delay between each key's animation start.
  /// Ignored if [staggerPattern] is null.
  final Duration staggerDelay;

  const KeyboardAnimationConfig({
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.staggerPattern,
    this.staggerDelay = const Duration(milliseconds: 50),
  });

  static const defaultConfig = KeyboardAnimationConfig();

  @override
  List<Object?> get props => [duration, curve, staggerPattern, staggerDelay];
}
