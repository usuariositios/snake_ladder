import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snake_ladder1/controllers/jugador_controller.dart';
import 'package:snake_ladder1/views/jugador_screen.dart';
import 'views/board_view.dart';
import 'views/inicio_screen.dart';
import 'package:get_storage/get_storage.dart';

void main() async  {
  await GetStorage.init();
  Get.put(JugadorController());
  runApp(GetMaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  getPages: [
      GetPage(name: '/', page: () => InicioScreen()),
      GetPage(name: '/board_screen', page: () => BoardView()), // tu pantalla del juego
      GetPage(name: '/jugador_screen', page: () => JugadorScreen()), // tu pantalla del juego
    ],

  ));//para que tenga un context
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Snake & Ladder GetX',
      theme: ThemeData(useMaterial3: true),
      home: BoardView(),
    );
  }
}