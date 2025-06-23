import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_ladder1/model/Snake.dart';

class SnakePainter extends CustomPainter {
  //final Snake snake;
  final List<Snake> snakeList;

  SnakePainter(this.snakeList);  

  @override
   void paint(Canvas canvas, Size size) {

    Paint paint = Paint();
    Random r = Random();

    List<Color> colors = [Colors.lightGreen,Colors.blue]; //,Colors.yellow,Colors.cyan , Colors.green, Colors.blue,Colors.orange Colors.red,

  for(final snake in snakeList){
    Color color = colors[r.nextInt(2)];
    paint = Paint()
      ..color = color
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;


      final path = Path();
      final from = snake.from;
      final to = snake.to;

      path.moveTo(from.dx, from.dy);//punto inicial
      int segments = 0; //snake.segmentos ; // Más segmentos = más ondulaciones  4

      final dx = (to.dx - from.dx) / segments;
      final dy = (to.dy - from.dy) / segments;

      for (int i = 0; i < segments; i++) {
        final isEven = i % 2 == 0;
        final controlPoint = Offset(
          from.dx + dx * i + (isEven ? 40 : -40), // alterna izquierda/derecha
          from.dy + dy * (i + 0.5),
        );
        final endPoint = Offset(//hasta llegar
          from.dx + dx * (i + 1),
          from.dy + dy * (i + 1),
        );

        path.quadraticBezierTo(
          controlPoint.dx,
          controlPoint.dy,
          endPoint.dx,
          endPoint.dy,
        );

        
    }
    canvas.drawPath(path, paint);
    dibujarHead(to.dx, to.dy-7, canvas, Size(18, 20), color);

      // 🐍 Curva de serpiente (Bezier)
      /*final midX = (from.dx + to.dx) / 2;
      final midY = (from.dy + to.dy) / 2;
      path.quadraticBezierTo(midX + 30, midY - 50, to.dx, to.dy);*/




      
    }
  }

  void dibujarHead(double dx,double dy,Canvas canvas, Size size, Color color){
    final paint = Paint()..color = color;
    final eyePaint = Paint()..color = Colors.black;
    final tonguePaint = Paint()..color = Colors.red;
    
    //canvas.save();
    //canvas.translate(dx + size.width/2,dy+ size.height/2);
    //canvas.translate(dx,dy);
    //canvas.rotate(0.3);
    

    //Lengua
    final tongueRect = Rect.fromLTWH(dx-(size.width*0.40/2), dy-(size.height/2)-4, size.width*0.40, size.height*0.60);
    canvas.drawOval(tongueRect, tonguePaint);

    // Cabeza ovalada
    final headRect = Rect.fromLTWH(dx-(size.width/2), dy-(size.height/2), size.width, size.height);
    canvas.drawOval(headRect, paint);
    //canvas.restore();
    
    

    // Ojos (dibujados como círculos)
    //final leftEyeCenter = Offset(size.width * 0.25, size.height * 0.3);
    //final rightEyeCenter = Offset(size.width * 0.75, size.height * 0.3);

    // Ojos exteriores
    //canvas.drawCircle(Offset(dx,dy-4), size.height * 0.07, eyePaint);
    //canvas.drawCircle(Offset(dx+4,dy+1), size.height * 0.07, eyePaint);

  }

  void paint1(Canvas canvas, Size size) {

    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

     

  for(final snake in snakeList){
      final path = Path();
      final from = snake.from;
      final to = snake.to;

    path.moveTo(from.dx, from.dy);

      // Calculamos puntos de control para una curva suave
    final controlPoint1 = Offset(
      from.dx + (to.dx - from.dx) * 0.5,
      from.dy,
    );
    
    final controlPoint2 = Offset(
      to.dx - (to.dx - from.dx) * 0.5,
      to.dy,
    );

    path.cubicTo(
      controlPoint1.dx, controlPoint1.dy,
      controlPoint2.dx, controlPoint2.dy,
      to.dx, to.dy,
    );
      canvas.drawPath(path, paint);
    }
  }



 

  @override
  bool shouldRepaint(covariant SnakePainter oldDelegate) {
    return false;//oldDelegate.snake != snake
  }
}