import 'package:flutter/material.dart';
import 'dart:math';

class ComicMensaje extends StatelessWidget {
  final String texto;
  final Offset offset;
  final Color color;
  final TextStyle? estiloTexto;
  final bool piquitoIzquierda;
  final VoidCallback? onCerrar;

  

  const ComicMensaje({
    Key? key,
    required this.texto,
    required this.offset,
    this.color = const Color(0xFFFFF59D), // Amarillo estilo cómic
    this.estiloTexto,
    this.piquitoIzquierda = true,
    this.onCerrar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //calcular el offset
     
    Offset offset1 = offset;
    final screenSize = MediaQuery.of(context).size;
    if(offset1.dx -200<0){//para controlar que no sobrepase el screen hacia la izquierda
      offset1 = Offset(0, offset.dy) ;
    }
    else if(offset.dx+200>screenSize.width){//para controlar que no sobrepase el screen hacia la derecha
      offset1 = Offset(offset1.dx -200, offset.dy) ;
    } 
    




    return 
    Stack(
      clipBehavior: Clip.none,
      children: [
Positioned(
      left: offset1.dx,
      top: offset1.dy,      
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 200,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(              
              color: color,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                )
              ],
            ),
            child: Text(
              texto,
              style: estiloTexto ??
                  const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Comic Sans MS', // Fuente estilo cómic (opcional)
                    color: Colors.black87,
                  ),
            ),
          ),
          if (onCerrar != null)
                  Positioned(
                    top: -4,
                    right: -4,
                    child: GestureDetector(
                      onTap: onCerrar,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ),
          
        ],
      ),
    )
        /*,
        Positioned(
            left: offset.dx-20,            
            top: offset.dy,//relativo al Positioned padre            
            child: Transform.rotate(
              angle: 45 * pi / 180,
              child: Container(
                width: 12,
                height: 12,
                color: color,
              ),
            ),
          ),*/
      ],
    );
    
  }
}