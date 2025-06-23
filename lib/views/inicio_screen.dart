import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snake_ladder1/controllers/inicio_controller.dart';





class InicioScreen extends StatefulWidget {
  @override
  _InicioScreenState createState() => _InicioScreenState();
}


class _InicioScreenState extends State<InicioScreen> {
  //late AppLocalizations t;
  final controller = Get.put(InicioController());
  
  late bool isDark;

  @override
  Widget build(BuildContext context) {
    //t = AppLocalizations.of(context)!;    
    //isDark = themeNotifier.value == ThemeMode.dark;
  

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A2980),
              Color(0xFF26D0CE),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Logo del juego (centrado)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/logo_drinkwars.png',
                    width: 250,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),

            // Botones principales (centrados verticalmente)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 150), // Espacio para el logo
                  
                  // Botón Jugar
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),),
                      onPressed: () {
                        controller.ir_boardscreen();
                      },
                      child: Text(
                        'empezar',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      ),
                    ),
                  ),
                
                  
                  const SizedBox(height: 20),
                  
                  // Botón Modos de Juego
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),),
                      onPressed: () {
                        controller.ir_jugadorscreen();
                        // Navegar a pantalla de modos de juego
                      },
                      child: Text(
                        'jugadores',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      ),                    
                    ),
                  )
                ],
              ),
            ),

            // Botón Configuración (parte inferior derecha)
            Positioned(
              bottom: 30,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.settings, size: 32),
                color: Colors.white,
                onPressed: () {

                  //_showSettingsDialog(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        
        return ValueListenableBuilder<Locale>(
        valueListenable: localeNotifier,
        builder: (_, __, ___) {
          final t = AppLocalizations.of(context);

        return AlertDialog(
          title: Text(t!.translate('configuracion')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(t.translate('tema')),                
                ElevatedButton(onPressed: () {
                          setState(() {
                            themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
                              
                          });},
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                  ],
                 )),
                Text(t.translate('idioma')),
                ElevatedButton(
                  onPressed: (){
                    localeNotifier.value =  localeNotifier.value.languageCode == 'es'? const Locale('en'): const Locale('es');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(localeNotifier.value.languageCode),
                      Icon(Icons.language),
                    ],
                  )
                ),
                
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(t.translate('cerrar')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
        }
      );

      },
    );
  }*/
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla de Juego')),
      body: const Center(child: Text('Contenido del juego')),
    );
  }
}