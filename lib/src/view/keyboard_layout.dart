import 'package:native_virtual_keyboard/src/model/virtual_keyboard_key.dart';

/// Defines a keyboard layout.
/// Feel free to extend this class to define your own keyboard layouts.
abstract class KeyboardLayout {
  final List<List<VirtualKeyboardKey>> layout;

  const KeyboardLayout({required this.layout});
}

final class EnglishQwertyKeyboardLayout extends KeyboardLayout {
  EnglishQwertyKeyboardLayout()
    : super(
        layout: [
          [
            VirtualKeyboardKey.q,
            VirtualKeyboardKey.w,
            VirtualKeyboardKey.e,
            VirtualKeyboardKey.r,
            VirtualKeyboardKey.t,
            VirtualKeyboardKey.y,
            VirtualKeyboardKey.u,
            VirtualKeyboardKey.i,
            VirtualKeyboardKey.o,
            VirtualKeyboardKey.p,
          ],
          [
            VirtualKeyboardKey.a,
            VirtualKeyboardKey.s,
            VirtualKeyboardKey.d,
            VirtualKeyboardKey.f,
            VirtualKeyboardKey.g,
            VirtualKeyboardKey.h,
            VirtualKeyboardKey.j,
            VirtualKeyboardKey.k,
            VirtualKeyboardKey.l,
          ],
          [
            VirtualKeyboardKey.enter,
            VirtualKeyboardKey.z,
            VirtualKeyboardKey.x,
            VirtualKeyboardKey.c,
            VirtualKeyboardKey.v,
            VirtualKeyboardKey.b,
            VirtualKeyboardKey.n,
            VirtualKeyboardKey.m,
            VirtualKeyboardKey.backspace,
          ],
        ],
      );
}
