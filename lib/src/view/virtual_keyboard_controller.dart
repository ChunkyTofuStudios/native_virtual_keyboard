import 'package:flutter/material.dart';
import 'package:native_virtual_keyboard/src/model/virtual_keyboard_key.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_layout.dart';

typedef KeyInteractionCallback = void Function(VirtualKeyboardKey key);

final class VirtualKeyboardController {
  /// The layout of the keyboard.
  final KeyboardLayout layout;

  /// Text style of keyboard keys.
  final TextStyle? textTheme;

  /// Text style of overlays.
  final TextStyle? overlayTextTheme;

  /// The callback to call when a key is held down.
  final KeyInteractionCallback? onKeyDown;

  /// The callback to call when a key is released or cancelled.
  /// Cancelled is when the pointer is moved outside of the key tap area.
  final KeyInteractionCallback? onKeyUp;

  /// The callback to call when a key is pressed.
  /// Synonimous with [onPressed].
  final KeyInteractionCallback? onKeyPress;

  const VirtualKeyboardController({
    required this.layout,
    this.textTheme,
    this.overlayTextTheme,
    this.onKeyDown,
    this.onKeyUp,
    required this.onKeyPress,
  });
}
