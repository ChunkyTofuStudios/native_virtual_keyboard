import 'package:flutter/widgets.dart';

/// Defines the visual properties for [VirtualKeyboard].
///
/// Descendant widgets obtain the current theme's [VirtualKeyboardThemeData] object
/// using [VirtualKeyboardTheme.of].
class VirtualKeyboardThemeData {
  final Color? backgroundColor;
  final Color? keyColor;
  final Color? keyIconColor;
  final Color? specialKeyBackgroundColor;
  final TextStyle? keyTextStyle;
  final bool? showEnter;
  final bool? showBackspace;
  final List<BoxShadow>? keyShadow;
  final List<BoxShadow>? keyInnerShadow;
  final double? specialKeyWidthMultiplier;

  const VirtualKeyboardThemeData({
    this.backgroundColor,
    this.keyColor,
    this.keyIconColor,
    this.specialKeyBackgroundColor,
    this.keyTextStyle,
    this.showEnter,
    this.showBackspace,
    this.keyShadow,
    this.keyInnerShadow,
    this.specialKeyWidthMultiplier,
  });

  /// Creates a copy of this object with the given fields replaced with the new values.
  VirtualKeyboardThemeData copyWith({
    Color? backgroundColor,
    Color? keyColor,
    Color? keyIconColor,
    Color? specialKeyBackgroundColor,
    TextStyle? keyTextStyle,
    bool? showEnter,
    bool? showBackspace,
    List<BoxShadow>? keyShadow,
    List<BoxShadow>? keyInnerShadow,
    double? specialKeyWidthMultiplier,
  }) {
    return VirtualKeyboardThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      keyColor: keyColor ?? this.keyColor,
      keyIconColor: keyIconColor ?? this.keyIconColor,
      specialKeyBackgroundColor:
          specialKeyBackgroundColor ?? this.specialKeyBackgroundColor,
      keyTextStyle: keyTextStyle ?? this.keyTextStyle,
      showEnter: showEnter ?? this.showEnter,
      showBackspace: showBackspace ?? this.showBackspace,
      keyShadow: keyShadow ?? this.keyShadow,
      keyInnerShadow: keyInnerShadow ?? this.keyInnerShadow,
      specialKeyWidthMultiplier: specialKeyWidthMultiplier ?? this.specialKeyWidthMultiplier,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is VirtualKeyboardThemeData &&
        other.backgroundColor == backgroundColor &&
        other.keyColor == keyColor &&
        other.keyIconColor == keyIconColor &&
        other.specialKeyBackgroundColor == specialKeyBackgroundColor &&
        other.keyTextStyle == keyTextStyle &&
        other.showEnter == showEnter &&
        other.showBackspace == showBackspace &&
        other.keyShadow == keyShadow &&
        other.keyInnerShadow == keyInnerShadow &&
        other.specialKeyWidthMultiplier == specialKeyWidthMultiplier;
  }

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        keyColor,
        keyIconColor,
        specialKeyBackgroundColor,
        keyTextStyle,
        showEnter,
        showBackspace,
        keyShadow,
        keyInnerShadow,
        specialKeyWidthMultiplier,
      );
}

/// An inherited widget that defines the visual properties for [VirtualKeyboard]s
/// in this widget's subtree.
class VirtualKeyboardTheme extends InheritedWidget {
  /// The [VirtualKeyboardThemeData] to apply to descendant [VirtualKeyboard]s.
  final VirtualKeyboardThemeData data;

  const VirtualKeyboardTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The data from the closest [VirtualKeyboardTheme] instance that encloses the given
  /// context.
  ///
  /// If there is no [VirtualKeyboardTheme] in the subtree, null is returned.
  static VirtualKeyboardThemeData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VirtualKeyboardTheme>()?.data;
  }

  @override
  bool updateShouldNotify(VirtualKeyboardTheme oldWidget) {
    return data != oldWidget.data;
  }
}
