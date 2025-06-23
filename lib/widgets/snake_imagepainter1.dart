import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class SnakeImagePainter1 extends CustomPainter {
  final Path path;
  final ui.Image snakeImage;
  final double progress;

  SnakeImagePainter1({
    required this.path,
    required this.snakeImage,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final metrics = path.computeMetrics().first;
    final pos = metrics.getTangentForOffset(metrics.length * progress);

    if (pos == null) return;

    final position = pos.position;
    final angle = pos.angle;

    final imageSize = 40.0;
    final dstRect = Rect.fromCenter(center: position, width: imageSize, height: imageSize);

    canvas.save();
    canvas.translate(position.dx, position.dy);
    canvas.rotate(angle);
    canvas.translate(-imageSize / 2, -imageSize / 2); // centrar imagen
    canvas.drawImage(snakeImage, Offset.zero, Paint());
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant SnakeImagePainter1 oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
