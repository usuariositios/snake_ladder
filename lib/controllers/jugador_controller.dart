import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snake_ladder1/model/jugador.dart';
import 'package:snake_ladder1/service/jugador_service.dart';


class JugadorController extends GetxController {
  final JugadorService _service = JugadorService();
  RxList<Jugador> jugadores = <Jugador>[].obs;
  var nombreColorJugador = "".obs;//nombre del color del jugador
  var colorJugador = Colors.white.obs;//color del jugador
  
  

  @override
  void onInit() {
    super.onInit();
    cargarJugadores();
  }

  void cargarJugadores() async {
    jugadores.value = await _service.cargarJugadores();
    
  }

  void agregarJugador(Jugador jugador) {
    jugadores.add(jugador);//aqui se agrega a la lista
    guardar();
  }

  void editarJugador(int index, Jugador jugador) {
    jugadores[index] = jugador;
    guardar();
  }

  void eliminarJugador(int index) {
    jugadores.removeAt(index);
    guardar();
  }

  void guardar() {
    _service.guardarJugadores(jugadores);
  }
}