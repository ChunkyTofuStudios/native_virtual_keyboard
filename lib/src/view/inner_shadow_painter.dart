import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InnerShadowPainter extends CustomPainter {
  final List<BoxShadow> shadows;
  final BorderRadius borderRadius;

  InnerShadowPainter({required this.shadows, required this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = borderRadius.toRRect(rect);

    canvas.clipRRect(rrect);

    for (final shadow in shadows) {
      final paint = shadow.toPaint();
      final spread = shadow.spreadRadius;
      final blur = shadow.blurRadius;
      final offset = shadow.offset;

      canvas.save();

      final holePath = Path()
        ..fillType = PathFillType.evenOdd
        ..addRect(rect.inflate(blur * 2 + spread + 10.0))
        ..addRRect(rrect.shift(offset));

      canvas.drawPath(holePath, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(InnerShadowPainter oldDelegate) =>
      !listEquals(oldDelegate.shadows, shadows) ||
      oldDelegate.borderRadius != borderRadius;
}
