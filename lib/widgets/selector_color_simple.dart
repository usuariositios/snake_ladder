import 'package:flutter/material.dart';

typedef OnSeleccionar = void Function(String nombreColor, Color color);//funcion que se invocara fuera del widget

class SelectorColorSimple extends StatelessWidget {
  final List<Color> colores;
  //final ValueChanged<String> onSeleccionar;
  final OnSeleccionar onSeleccionar;
  


  const SelectorColorSimple({
    Key? key,
    required this.colores,
    required this.onSeleccionar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(//lista de colores
      spacing: 8,
      children: colores.map((color) {
        return GestureDetector(
          onTap: () => onSeleccionar(obtenerNombreColor(color),color),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black),
            ),
          ),
        );
      }).toList(),
    );
  }
String obtenerNombreColor(Color color) {
  Map<Color, String> coloresMaterial = {
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

  for (var entry in coloresMaterial.entries) {
    if (entry.key.value == color.value) {
      return entry.value;
    }
  }

  return 'desconocido'; // si no se encuentra coincidencia exacta
}

}


