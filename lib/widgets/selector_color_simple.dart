import 'package:flutter/material.dart';
import 'package:snake_ladder1/utils/Utils.dart';

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
          onTap: () => onSeleccionar(Utils.obtenerNombreColor(color),color),
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


}


