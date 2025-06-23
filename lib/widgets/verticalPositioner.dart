import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class VerticalSvgPositioner extends StatelessWidget {
  final Offset start;
  final Offset end;
  final double svgHeight;
  final String svgAsset;
  final Color? debugColor;

  const VerticalSvgPositioner({
    super.key,
    required this.start,
    required this.end,
    required this.svgHeight,
    required this.svgAsset,
    this.debugColor,
  });

  @override
  Widget build(BuildContext context) {
    final delta = end - start;
    final distance = delta.distance;
    final angle = delta.direction + (math.pi / 2);
    final scale = distance / svgHeight;

    // Calcular el centro de rotación (parte inferior del SVG)
    final rotationCenter = Offset(0, svgHeight / 2 * scale);

    return Stack(
      children: [
        // Puntos de debug (opcional)
        if (debugColor != null) ...[
          Positioned(
            left: start.dx - 5,
            top: start.dy - 5,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: debugColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: end.dx - 5,
            top: end.dy - 5,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: debugColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          
        ],

        // SVG con transformación corregida
        Positioned(
          left: start.dx-100,
          top: start.dy+70,
          child: Transform(
            transform: Matrix4.identity()
              ..translate(rotationCenter.dx, rotationCenter.dy)
              ..rotateZ(angle)
              ..scale(scale),
            alignment: Alignment.topCenter,
            child: Transform.translate(
              offset: Offset(0, -svgHeight / 2 * scale), // Ajuste fino de posición
              child: SvgPicture.asset(
                svgAsset,
                height: svgHeight,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
        ),
      ],
    );
  }
}