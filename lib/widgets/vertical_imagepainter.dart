import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class VerticalImagePainter extends CustomPainter {
  final ui.Image image;
  final Offset from;
  final Offset to;

  VerticalImagePainter({
    required this.image,
    required this.from,
    required this.to,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final dx = to.dx - from.dx;
    final dy = to.dy - from.dy;
    final distance = sqrt(dx * dx + dy * dy);
    final angle = atan2(dy, dx); // rotación necesaria

    final imageAspectRatio = image.height / image.width;
    final imageWidth = 40.0; // ancho deseado de la imagen en pantalla
    final imageHeight = distance;

    final dstRect = Rect.fromLTWH(0, 0, imageWidth, imageHeight);

    canvas.save();
    canvas.translate(from.dx, from.dy); // mover al punto inicial
    canvas.rotate(angle); // rotar hacia el punto final

    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      dstRect,
      Paint(),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant VerticalImagePainter oldDelegate) => false;
}