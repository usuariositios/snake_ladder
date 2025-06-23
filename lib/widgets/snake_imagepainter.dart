import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class SnakePainterImg extends CustomPainter {
  final Path path;
  final ui.Image segmentImage;

  SnakePainterImg({
    required this.path,
    required this.segmentImage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final metrics = path.computeMetrics().toList();

    for (final metric in metrics) {
      const spacing = 30.0; // espacio entre segmentos
      for (double dist = 0; dist < metric.length; dist += spacing) {
        final pos = metric.getTangentForOffset(dist);
        if (pos == null) continue;

        final imageSize = 24.0;
        final offset = pos.position;
        final angle = pos.angle;

        canvas.save();
        canvas.translate(offset.dx, offset.dy);
        canvas.rotate(angle);
        canvas.translate(-imageSize / 2, -imageSize / 2);
        canvas.drawImageRect(
          segmentImage,
          Rect.fromLTWH(0, 0, segmentImage.width.toDouble(), segmentImage.height.toDouble()),
          Rect.fromLTWH(0, 0, imageSize, imageSize),
          Paint(),
        );
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant SnakePainterImg oldDelegate) => false;
}