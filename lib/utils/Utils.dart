import 'package:flutter/material.dart';
class Utils {
  static Map<Color, String> coloresMaterial = {
    Colors.red: 'red',
    Colors.pink: 'pink',
    Colors.purple: 'purple',
    Colors.deepPurple: 'deepPurple',
    Colors.indigo: 'indigo',
    Colors.blue: 'blue',
    Colors.lightBlue: 'lightBlue',
    Colors.cyan: 'cyan',
    Colors.teal: 'teal',
    Colors.green: 'green',
    Colors.lightGreen: 'lightGreen',
    Colors.lime: 'lime',
    Colors.yellow: 'yellow',
    Colors.amber: 'amber',
    Colors.orange: 'orange',
    Colors.deepOrange: 'deepOrange',
    Colors.brown: 'brown',
    Colors.grey: 'grey',
    Colors.blueGrey: 'blueGrey',
    Colors.black: 'black',
    Colors.white: 'white',
  };
  static String obtenerNombreColor(Color color) {  

  for (var entry in coloresMaterial.entries) {
    if (entry.key.value == color.value) {
      return entry.value;
    }
  }

  return 'desconocido'; // si no se encuentra coincidencia exacta
}
static Color obtenerColorNombre(String color) { //Color color
  

  for (var entry in coloresMaterial.entries) {
        if (entry.value == color) {
      return entry.key;
    }
  }

  return Colors.white; // si no se encuentra coincidencia exacta
}

}