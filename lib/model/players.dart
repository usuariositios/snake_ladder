import 'dart:ui';

import 'package:get/get_rx/get_rx.dart';

class Players {
  String nombre = "";
  int numUbic = 1;
  Rx<Offset> posicion = Offset(100, 300).obs;//posicion antes y despues de la animacion
  String colorPlayers = "";
}