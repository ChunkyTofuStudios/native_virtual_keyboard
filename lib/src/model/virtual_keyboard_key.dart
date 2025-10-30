import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum VirtualKeyboardKey {
  backspace('⌫', icon: Symbols.backspace),
  enter('↵', icon: Symbols.check),
  a('A'),
  b('B'),
  c('C'),
  d('D'),
  e('E'),
  f('F'),
  g('G'),
  h('H'),
  i('I'),
  j('J'),
  k('K'),
  l('L'),
  m('M'),
  n('N'),
  o('O'),
  p('P'),
  q('Q'),
  r('R'),
  s('S'),
  t('T'),
  u('U'),
  v('V'),
  w('W'),
  x('X'),
  y('Y'),
  z('Z');

  const VirtualKeyboardKey(this.text, {this.icon});

  final String text;
  final IconData? icon;

  bool get special => icon != null;

  static VirtualKeyboardKey? fromChar(String char) {
    return VirtualKeyboardKey.values.firstWhereOrNull(
      (key) => key.text.toLowerCase() == char.toLowerCase(),
    );
  }
}
