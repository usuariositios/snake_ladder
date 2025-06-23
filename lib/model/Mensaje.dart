import 'dart:ui';

class Mensaje {
  final String texto;
  final Offset offset;
  final Color color;
  final bool piquitoIzquierda;

  Mensaje({
    required this.texto,
    required this.offset,
    this.color = const Color(0xFFFFF59D),
    this.piquitoIzquierda = true,
  });
}