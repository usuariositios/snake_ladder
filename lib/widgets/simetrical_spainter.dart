import 'package:flutter/material.dart';

class SymmetricalSPainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final Color color;
  final double strokeWidth;

  SymmetricalSPainter({
    required this.start,
    required this.end,
    this.color = Colors.black,
    this.strokeWidth = 3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final path = createSymmetricalSPath(start, end);
    canvas.drawPath(path, paint);
  }

  Path createSymmetricalSPath(Offset start, Offset end) {
    final path = Path();
    final center = Offset(
      (start.dx + end.dx) / 2,
      (start.dy + end.dy) / 2,
    );

    // Calculamos la dirección y magnitud
    final totalWidth = end.dx - start.dx;
    final totalHeight = end.dy - start.dy;
    
    // Puntos de control para la primera curva (parte superior de la S)
    final control1Top = Offset(
      start.dx + totalWidth * 0.5,
      start.dy,
    );
    final control2Top = Offset(
      end.dx - totalWidth * 0.5,
      center.dy,
    );
    
    // Puntos de control para la segunda curva (parte inferior de la S)
    final control1Bottom = Offset(
      start.dx + totalWidth * 0.5,
      center.dy,
    );
    final control2Bottom = Offset(
      end.dx - totalWidth * 0.5,
      end.dy,
    );

    // Construimos el path
    path.moveTo(start.dx, start.dy);
    
    // Primera curva (parte superior)
    path.cubicTo(
      control1Top.dx, control1Top.dy,
      control2Top.dx, control2Top.dy,
      center.dx, center.dy,
    );
    
    // Segunda curva (parte inferior)
    path.cubicTo(
      control1Bottom.dx, control1Bottom.dy,
      control2Bottom.dx, control2Bottom.dy,
      end.dx, end.dy,
    );

    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}