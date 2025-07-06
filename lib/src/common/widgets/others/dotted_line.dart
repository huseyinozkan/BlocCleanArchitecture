import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class DottedLine extends StatelessWidget {
  const DottedLine({
    super.key,
    this.height = 1,
    this.color,
    this.dashWidth = 5,
    this.dashSpace = 3,
  });
  final double height;
  final Color? color;
  final double dashWidth;
  final double dashSpace;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, height),
      painter: _DottedLinePainter(
        color: color ?? context.colorScheme.onSurface.withValues(alpha: 0.5),
        dashWidth: dashWidth,
        dashSpace: dashSpace,
      ),
    );
  }
}

@immutable
final class _DottedLinePainter extends CustomPainter {
  const _DottedLinePainter({
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
  });
  final Color color;
  final double dashWidth;
  final double dashSpace;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.height
      ..style = PaintingStyle.stroke;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
