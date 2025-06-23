import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class SnakePositioner extends StatelessWidget {
  final Offset inicio;
  final Offset fin;  
  final String asset;

  const SnakePositioner({
    super.key,
    required this.inicio,
    required this.fin,    
    required this.asset,    
  });

  @override
  Widget build(BuildContext context) {
    final dx = fin.dx - inicio.dx;
    final dy = fin.dy - inicio.dy;

    final angle = math.atan2(dy, dx); // en radianes
    final distance = math.sqrt(dx * dx + dy * dy); // largo total
// Tamaño base del SVG (debe coincidir con el real)
    const double baseHeight = 586;
    const double baseWidth = 97;

    return Stack(
        children: [
          Positioned(
            left: inicio.dx,
            top: inicio.dy,
            child: Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.identity()
                ..translate(0.0, 0.0)
                ..rotateZ(angle)
                ..scale(1.0, distance / baseHeight),
              child: SvgPicture.asset(
                asset,
                width: baseWidth,
                height: baseHeight,
              ),
            ),
          ),
        ],
      );
  }
}