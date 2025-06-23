import 'package:get/get.dart';

class InicioController extends GetxController {
  var idioma = 'es'.obs; // 'es' o 'en'
  var nombreJugador = ''.obs;
  var numeroJugadores = 2.obs;

  void cambiarIdioma(String nuevo) {
    idioma.value = nuevo;
  }

  void cambiarNumeroJugadores(int numero) {
    numeroJugadores.value = numero;
  }

  void ir_boardscreen() {
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