import 'package:get/get.dart';
import 'package:snake_ladder1/controllers/jugador_controller.dart';

class InicioController extends GetxController {
  var idioma = 'es'.obs; // 'es' o 'en'
  var nombreJugador = ''.obs;
  var numeroJugadores = 2.obs;
  final jugadorController = Get.put(JugadorController());

  void cambiarIdioma(String nuevo) {
    idioma.value = nuevo;
  }

  void cambiarNumeroJugadores(int numero) {
    numeroJugadores.value = numero;
  }

  void ir_boardscreen() {
    if(jugadorController.jugadores.length<=1){
      Get.defaultDialog(
        title: 'Jugadores',
        middleText: 'Registra al menos dos jugadores',
        textConfirm: 'Aceptar',
        
        onConfirm: () {
          Get.back(); // cerrar diálogo
        },
        
      );
      return;      
    }
    // Validación simple
    /*if (nombreJugador.value.trim().isEmpty) {
      Get.snackbar('Error', 'Por favor ingresa tu nombre.');
      return;
    }*/

    // Ir a la pantalla principal del juego
    Get.toNamed('/board_screen', arguments: {
      'idioma': idioma.value,
      'nombreJugador': nombreJugador.value,
      'numeroJugadores': numeroJugadores.value,
    });
  }

  void ir_jugadorscreen() {
    // Validación simple
    /*if (nombreJugador.value.trim().isEmpty) {
      Get.snackbar('Error', 'Por favor ingresa tu nombre.');
      return;
    }*/

    // Ir a la pantalla principal del juego
    Get.toNamed('/jugador_screen', arguments: {
      'idioma': idioma.value,
      'nombreJugador': nombreJugador.value,
      'numeroJugadores': numeroJugadores.value,
    });
  }

}