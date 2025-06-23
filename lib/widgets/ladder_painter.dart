import 'package:flutter/material.dart';
import 'package:snake_ladder1/model/Ladder.dart';

class LadderPainter extends CustomPainter {
  final List<Ladder> ladderList;

  //required this.start, required this.end, this.steps = 9

  LadderPainter(this.ladderList);

  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;



    for(final ladder in ladderList)  {

    // Vector entre inicio y fin
    final vector = ladder.to - ladder.from;
    final perpendicular = Offset(-vector.dy, vector.dx).normalize();

    // Separación entre las dos líneas laterales
    const width = 20.0;
    final p1 = ladder.from + perpendicular * (width / 2);
    final p2 = ladder.from - perpendicular * (width / 2);
    final p3 = ladder.to + perpendicular * (width / 2);
    final p4 = ladder.to - perpendicular * (width / 2);

    // Dibuja los lados de la escalera
    canvas.drawLine(p1, p3, paint);
    canvas.drawLine(p2, p4, paint);

    // Dibuja los escalones
    for (int i = 0; i <= ladder.pasos; i++) {
      if(i!=0 && i!=ladder.pasos){ //sin el primer y ultimo escalon
      double t = i / ladder.pasos;
      Offset a = Offset.lerp(p1, p3, t)!;
      Offset b = Offset.lerp(p2, p4, t)!;
      canvas.drawLine(a, b, paint);
      }
    }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

extension on Offset {
  Offset normalize() {
    final length = distance;
    return length == 0 ? this : this / length;
  }
}