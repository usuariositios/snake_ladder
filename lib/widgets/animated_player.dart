import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snake_ladder1/model/Mensaje.dart';
import 'package:snake_ladder1/widgets/custom_modal.dart';



class AnimatePlayerController extends GetxController with GetTickerProviderStateMixin   {
  
  late AnimationController _controller;  
  late Animation<double> _animation;
  late List<Offset> ruta ;
  late int indiceActual;
  late Rx<Offset> posicion;
  late int indiceAnimacion = 0;
  RxList<Mensaje> mensajeList = <Mensaje>[].obs;
  int swMostrarMensaje = 0;//sw que indica que se mostrara el mensaje comic
  String mensaje = "";


  @override
  void onInit() {
    super.onInit();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 153),
    );

_animation = CurvedAnimation(//definicion de la animacion
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _animation.addListener(() {//monitorea la lista y cada salto
      
      if (ruta.isEmpty || indiceActual >= ruta.length-1){//llegan varios estados de la animacion
        indiceAnimacion++;
        //print('indiceAnimacion $indiceAnimacion  $swMostrarMensaje ');
        if(indiceAnimacion>=11){//llegan 12 animaciones finalizadas
          if(swMostrarMensaje==1)
            {
              mostrarMensaje(texto: mensaje, offset: ruta[indiceActual]);
              swMostrarMensaje = 0;
            }
          indiceAnimacion = 0;
        }
        return;
      }
      

      double t = _animation.value;

      Offset inicio = ruta[indiceActual];
      Offset fin = ruta[indiceActual + 1];
      //print('salto de $indiceActual   a ${indiceActual+1}' );

      // Movimiento lineal
      Offset posLineal = Offset.lerp(inicio, fin, t)!;

      // Agregar altura de salto
      double altura = -30 * sin(pi * t); // Salto hacia arriba

      posicion.value = Offset(//actualiza la posicion parece que se actualiza constantemente
        posLineal.dx,
        posLineal.dy + altura,
      );
    });
    _animation.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {//cuando se completa la animzacion
      
        indiceActual++;
        //print('indiceActual $indiceActual');
        if (indiceActual <= ruta.length- 1) { // - 1  indiceactual llega a la longitud de ruta
        
          await Future.delayed(Duration(milliseconds: 100)); // pequeña pausa entre saltos
          _controller.reset();
          _controller.forward();
        }
      }
    });
  }

  

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  

   void mover() async {
    _controller.reset();
    await _controller.forward();
    
    //await Future.delayed(Duration(milliseconds: 153*(ruta.length +1 )));
    
    
  }  

  void mostrarMensaje({
    required String texto,
    required Offset offset,
    Color color = const Color(0xFFFFF59D),
    bool piquitoIzquierda = true,
  }) {
    mensajeList.add(Mensaje(
      texto: texto,
      offset: offset,
      color: color,
      piquitoIzquierda: piquitoIzquierda,
    ));

    // Ocultar mensaje después de 3 segundos (opcional)
    /*Future.delayed(Duration(seconds: 3), () {
      mensajeList.removeAt(0); // o usa alguna lógica para identificar y eliminar el mensaje
    });*/
  }

   void mostrarTarjeta() async{
        //Future.delayed(Duration(milliseconds: 153*(ruta.length +1 )));

        Future.delayed(Duration.zero, () {
        Get.dialog(
          CustomModal(
        title: 'Modal Reutilizable',
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Este es un modal completamente personalizable.'),
            SizedBox(height: 10),
            FlutterLogo(size: 50),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica adicional antes de cerrar
              Get.back();
              Get.snackbar('Éxito', 'Acción confirmada');
            },
            child: const Text('Confirmar'),
          ),
        ],
        ),
      );
      });
  }
}



Image.asset(
                                    'assets/images/user.png',
                                      width: screenAnc *0.1,
                                      height: screenAnc *0.1,                                    
                          
                                    ),
									
Image.asset(
                                    'assets/images/user.png',
                                      width: screenAnc *0.1,
                                      height: screenAnc *0.1,                                    
                          
                                    ),
									
boardController.numFicha.value==0?4.0:
boardController.numFicha.value==1?4.0:
fontWeight: FontWeight.bold,
fontWeight: FontWeight.bold,