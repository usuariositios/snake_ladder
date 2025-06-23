import 'package:flutter/material.dart';

class Jugador {
  String nombre;
  int edad;
  int numCaja = 1;
  String nombreColorJugador = "green";
  Color colorJugador;

  Jugador({required this.nombre, required this.edad,required this.numCaja,required this.nombreColorJugador,required this.colorJugador});

  factory Jugador.fromJson(Map<String, dynamic> json) {
    return Jugador(
      nombre: json['nombre'],
      edad: json['edad'],
      numCaja: json['numCaja'],
      nombreColorJugador: json['colorJugador'],
      colorJugador:Colors.white
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'edad': edad,
      'numCaja': numCaja,
      'colorJugador': nombreColorJugador
    };
  }
}