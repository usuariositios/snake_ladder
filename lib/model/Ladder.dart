import 'package:flutter/widgets.dart';

class Ladder {
  final Offset from;
  final Offset to;
  int pasos;  

  Ladder({required this.from, required this.to, this.pasos=9});
}