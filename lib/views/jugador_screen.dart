import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:snake_ladder1/controllers/jugador_controller.dart';
import 'package:snake_ladder1/model/jugador.dart';
import 'package:snake_ladder1/widgets/selector_color_simple.dart';



class JugadorScreen extends StatelessWidget {
  JugadorScreen({Key? key}) : super(key: key);

  final JugadorController controller = Get.put(JugadorController());
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController edadController = TextEditingController();
  

  void _showAddDialog(BuildContext context) {
    nombreController.clear();
    edadController.clear();
    controller.nombreColorJugador.value = "";
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Agregar Jugador'),
        content: Obx(() =>Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nombreController, decoration: const InputDecoration(labelText: 'Nombre')),
            SizedBox( height: 20,),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: controller.colorJugador.value,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black),
                  ),
                ),
                seleccionarColores(context),
              ],
            ),
            
          ],
        )),
        actions: [
          TextButton(
            onPressed: () {
              final nombre = nombreController.text.trim();
              final edad = int.tryParse(edadController.text.trim()) ?? 0;

              if (nombre.isNotEmpty) {
                //print('nombreColor seleccionado: $nombreColor');
                controller.agregarJugador(Jugador(nombre: nombre, edad: edad,numCaja: 1,nombreColorJugador: controller.nombreColorJugador.value,colorJugador: controller.colorJugador.value));
                Navigator.pop(context);
              }
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, int index) {
    final jugador = controller.jugadores[index];
    nombreController.text = jugador.nombre;
    edadController.text = jugador.edad.toString();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Editar Jugador'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nombreController, decoration: const InputDecoration(labelText: 'Nombre')),
            TextField(controller: edadController, decoration: const InputDecoration(labelText: 'Edad'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final nombre = nombreController.text.trim();
              final edad = int.tryParse(edadController.text.trim()) ?? 0;

              if (nombre.isNotEmpty && edad > 0) {
                controller.editarJugador(index, Jugador(nombre: nombre, edad: edad,numCaja: 1,nombreColorJugador: controller.nombreColorJugador.value,colorJugador: controller.colorJugador.value));
                Navigator.pop(context);
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jugadores')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
      body: Obx(() => ListView.builder(
            itemCount: controller.jugadores.length,
            itemBuilder: (context, index) {
              final jugador = controller.jugadores[index];
              return ListTile(
                title: Text(jugador.nombre),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: jugador.colorJugador,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                    IconButton(onPressed: () => _showEditDialog(context, index), icon: const Icon(Icons.edit)),
                    IconButton(onPressed: () => controller.eliminarJugador(index), icon: const Icon(Icons.delete)),
                  ],
                ),
              );
            },
          )),
    );
  }
  Widget seleccionarColores(BuildContext context){
    return ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Elige un color'),
                  content: SelectorColorSimple(
                    colores: [
                      Colors.red,
                      Colors.green,
                      Colors.blue,
                      Colors.yellow,
                      Colors.orange,
                      Colors.purple,
                    ],
                    onSeleccionar: (nombreColor,color) {
                      Navigator.of(context).pop(); // Cierra el diálogo
                      //print('Color elegido: ${controller.nombreColorJugador.value} ');
                      
                        controller.nombreColorJugador.value = nombreColor;
                        controller.colorJugador.value = color;
                      

                      // Aquí puedes actualizar un controlador, setState, etc.
                    },
                  ),
                );
              },
            );
          },
          child: const Text('Color'),
  );
  }
}