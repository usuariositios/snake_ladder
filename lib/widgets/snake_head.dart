import 'package:flutter/material.dart';
class SnakeHead extends StatelessWidget {
  final Offset position;  
  final double width;
  final double height;
  final double angle; //
  final Color headColor;
  final Color eyeColor;

  const SnakeHead({
    super.key,
    required this.position,
    required this.width,
    required this.height,
    required this.angle,
    this.headColor = Colors.green,
    this.eyeColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx - width / 2,
      top: position.dy - height / 2,
      child: 
      Transform.rotate(
        angle: angle,
        origin: Offset(width / 2,height / 2), // Rotar desde el centro

          child: CustomPaint(
            size: Size(width, height),
            painter: _SnakeHeadPainter(
              headColor: headColor,
              eyeColor: eyeColor,
            ),
          ),

      )
    );
  }
}

class _SnakeHeadPainter extends CustomPainter {
  final Color headColor;
  final Color eyeColor;

  _SnakeHeadPainter({
    required this.headColor,
    required this.eyeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = headColor;
    final eyePaint = Paint()..color = eyeColor;
    

    // Cabeza ovalada
    final headRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawOval(headRect, paint);

    // Ojos (dibujados como círculos)
    final leftEyeCenter = Offset(size.width * 0.25, size.height * 0.3);
    final rightEyeCenter = Offset(size.width * 0.75, size.height * 0.3);

    // Ojos exteriores
    canvas.drawCircle(leftEyeCenter, size.height * 0.07, eyePaint);
    canvas.drawCircle(rightEyeCenter, size.height * 0.07, eyePaint);

    

    

    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}